require 'codebreaker-web/view'
require 'codebreaker-web/config'
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
      out_guess = game.guess(guess)

      game_end_won(response, cookies) if out_guess == '++++'

      new_attempts = attempts << {guess: guess, output: out_guess}
      response.set_cookie 'attempts', JSON.generate(new_attempts)
    end

    def self.game_end_won(response, cookies)
      statistics = JSON.parse cookies['statistics']
      user = cookies['user']
      attempts_left = cookies['attempts_left']
      statistics << {user: user, score: attempts_left.to_i + 1}
      response.set_cookie 'statistics', JSON.generate(statistics)
      response.set_cookie 'won', '1'
    end
  end
end
