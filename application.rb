class Application
  attr_reader :game, :dictionary

  def initialize
    @counter    = 0
    @game       = GuessingGame.new
    @dictionary = Dictionary.new('/usr/share/dict/words')
  end

  def prepare_response(request)
    @counter    += 1
    status, body = process(request)
    Response.new(status, body, request.debugging_info)
  end

  def process(request)
    case "#{request.method} #{request.path}"
    when 'GET /'
      [200, ""]
    when 'GET /hello'
      [200, "Hello, world (#{@counter})"]
    when 'GET /datetime'
      [200, Time.now.strftime("%l:%m%p on %A, %B %e, %Y")]
    when 'GET /shutdown'
      [200, "Total requests: #{@counter}. Goodbye."]
    when 'GET /word_search'
      [200, dictionary.word_lookup(request.params["word"])]
    when 'POST /start_game'
      game.setup
      [301, "Good luck!"]
    when 'GET /game'
      [200, game.results]
    when 'POST /game'
      game.guess(request.params["guess"])
      [301, "/game"]
    when 'GET /force_error'
      begin
      raise SystemStackError
      rescue SystemStackError => e
      [500, "#{e.class}: #{e.backtrace}"]
      end
    else
      [404, "Not found"]
    end
  end
end