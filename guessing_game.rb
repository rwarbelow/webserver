class GuessingGame
  attr_reader :secret_number,
              :current_guess,
              :guesses,
              :playing

  def setup
    @secret_number = rand(100)
    @guesses       = 0
    @playing       = true
  end  

  def guess(number)
    if playing
      @current_guess = number.to_i
      increment_guesses!
    else
      setup
      guess(number)
    end
  end

  def increment_guesses!
    @guesses += 1
  end

  def results
    if @guesses > 0
      "#{guesses} guesses taken.\nMost recent guess (#{current_guess}) was #{comparison}."
    else
      "No guesses have been made."
    end
  end

  def comparison
    if secret_number == current_guess
      "just right"
    elsif current_guess > secret_number
      "too high"
    else
      "too low"
    end
  end
end