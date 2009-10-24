require 'net/http'
require 'cgi'
require 'mq'

module Trapeze
  class AMQPConnector
    DEFAULT_SERVER = 'localhost'
    DEFAULT_BINDING = '#'
    DEFAULT_QNAME = 'ruby'
    
    def initialize(binding, queue_name, server_address, handler)
      @binding = binding
      @queue_name = queue_name
      @server_address = server_address
      @handler = handler
    end
  
    def start
      #AMQP.settings[:logging] = true
      AMQP.start(:host => @server_address) do
        MQ.queue(@queue_name, :auto_delete => true).bind('trapeze', :key => @binding).subscribe do |header, body|
          @handler.handle_request(AMQPRequest.new(header, body))
        end
      end
    end
    
    def stop
      AMQP.stop { EM.stop }
    end
  end

  class AMQPRequest
    attr_reader :body
  
    def initialize(header, body)
      @header = header
      @body = body
      @response_buffer = StringIO.new
      @closed = false
    end

    def makefile(mode, bufsize)
      if mode[0] == 'r':
        StringIO.new(@body)
      elsif mode[0] == 'w':
        self
      end
    end

    def write(x)
      @response_buffer.write(x)
    end

    def flush
    end
  
    def close
      if not @closed
        @response_buffer.flush
        resp_body = @response_buffer.string

        begin
          mq = MQ.new(AMQP.conn)
          mq.direct('').publish(resp_body, :key => @header.properties[:reply_to], :correlation_id => @header.properties[:message_id])
        rescue
          puts $@
          puts $!
        end
        @closed = true
      end
    end
  end
end

# Monkey-patch for MQ::Queue to prevent routing key being lost...
class MQ
  class Queue
    alias :old_bind :bind
    
    def bind(exchange, opts = {})
      opts_to_save = opts.dup
      result = old_bind(exchange, opts)
      @bindings[exchange] = opts_to_save
      
      result
    end
  end
end
