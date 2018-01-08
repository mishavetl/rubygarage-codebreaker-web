require 'codebreaker-web/view'
require 'codebreaker'
require 'json'

module CodebreakerWeb
  class Guess
    def self.call(env)
      request = Rack::Request.new env
      response = Rack::Response.new

      cookies = request.cookies
      response.set_cookie('attempts_left', cookies['attempts_left'].to_i - 1)

      actualCode = cookies['code']
      guess = request.params['guess']

      if actualCode.nil?
        response.redirect('/')
        return response.finish
      end

      if guess.nil?
        response.redirect('/')
        return response.finish
      end

      match_guess actualCode, guess, cookies, response

      response.redirect '/game'
      response.finish
    end

    def self.match_guess(actualCode, guess, cookies, response)
      game = Codebreaker::Game.new
      game.start 1
      game.instance_variable_set('@code', actualCode)
      attempts = JSON.parse(cookies['attempts'])
      new_attempts = attempts << {guess: guess, output: game.guess(guess)}
      response.set_cookie 'attempts', JSON.generate(new_attempts)
    end
  end
end
