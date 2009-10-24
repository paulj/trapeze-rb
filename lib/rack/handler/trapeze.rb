module Rack
  module Handler
    # Rack Handler stricly to be able to use Hookout through the rackup command.
    # To do so, simply require 'trapeze' in your Rack config file and run like this
    #
    #   rackup --server trapeze
    #
    class Trapeze
      def self.run(app, options={})
        # Determine our host
        host = options[:Host] || 'localhost'
        
        # Determine our label
        label = options[:Port] || '#'
        label = '#' if label.to_i != 0
        
        # Determine our queue name
        queue_name = options[:Queue_Name] || 'ruby'
        
        server = ::Trapeze::AMQPConnector.new(
          label, 
          queue_name,
          host,
          ::Trapeze::RackAdapter.new(app))
          
        yield server if block_given?
        server.start
      end
    end
    
    register 'trapeze', 'Rack::Handler::Trapeze'
  end
end