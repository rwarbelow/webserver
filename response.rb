class Response
  attr_reader :body, :headers, :status

  def initialize(status, body, debugging_info)
    @status = status
    @body = "#{body} #{debugging_info}"
    @headers = prepare_headers
    @headers << "location: http://localhost:9292/game" if status == 302 || status == 301
  end

  def prepare_headers
    [
      "http/1.1 #{status}",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{body.length}\n\n",
    ]
  end
end