$:.unshift File.expand_path(File.dirname(__FILE__))

require 'trapeze/amqp_connector'
require 'trapeze/rack_adapter'
require 'trapeze/runner'
require 'trapeze/thin_backend'
require 'rack/handler/trapeze'