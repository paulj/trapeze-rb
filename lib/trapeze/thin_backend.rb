module Trapeze
  # Backend allowing Thin to listen on an AMQP connection
  class ThinBackend < Thin::Backends::Base
    # Address and port on which the server is listening for connections.
    attr_accessor :server_address, :label
    
    def initialize(server, label, options)
      @key = options[:key]
      @label = options[:label]
      @server_address = options[:address]
      
      super()
    end
    
    # Connect the server
    def connect
      @connector = AMQPConnector.new(@key, @label, @server_address, self)
      @connector.start
    end
    
    # Stops the server
    def disconnect
      @connector.stop
    end
          
    def to_s
      "#{@label} via #{@server_address}"
    end
    
    def handle_request(request)
      connection = ThinConnection.new(request.to_s)
      connection.amqp_req = request
      connection.backend = self
      initialize_connection(connection)
      
      connection.receive_data(request.body)
      #connection.process  -- Invoked automatically by receive_data
    end
  end
  
  class ThinConnection < Thin::Connection
    attr_accessor :amqp_req
    attr_accessor :backend
    
    def persistent?
      false
    end
    
    def comm_inactivity_timeout=(timeout)
      # Ignore
    end
    
    def send_data(data)
      @amqp_req.write(data)
    end
    
    def close_connection_after_writing
      begin
        @amqp_req.close
      ensure
        @backend.connection_finished(self)
      end
    end
  end
end