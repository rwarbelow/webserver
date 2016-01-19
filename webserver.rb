require 'socket'
require_relative 'request'
require_relative 'response'
require_relative 'application'
require_relative 'dictionary'
require_relative 'guessing_game'

class Webserver
  attr_reader :port

  def initialize(port)
    @port        = port
  end

  def serve(app)
    tcp_server = TCPServer.new(port)
    loop do
      client = tcp_server.accept
      request = Request.create(client)
      response = app.prepare_response(request)
      client.puts response.headers.join("\n")
      client.puts response.body
    end
  end
end

app = Application.new
Webserver.new(9292).serve(app)