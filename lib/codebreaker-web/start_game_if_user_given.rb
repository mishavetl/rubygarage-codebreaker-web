require 'codebreaker-web/view'
require 'codebreaker-web/config'
require 'codebreaker'

module CodebreakerWeb
  class StartGameIfUserGiven
    def initialize(app)
      @app = app
    end

    def reset_cookies(request, response)
      user = request.params['user']
      code = Codebreaker::Game.new.generate(4)
      attempts = JSON.generate []
      statistics = request.cookies['statistics'] || '[]'
      response.set_cookie 'user', user
      response.set_cookie 'attempts_left', Config.attempts_amount
      response.set_cookie 'code', code
      response.set_cookie 'attempts', attempts
      response.set_cookie 'last_hint', ''
      response.set_cookie 'hints', '0'
      response.set_cookie 'statistics', statistics
      response.set_cookie 'won', '0'
    end

    def call(env)
      request = Rack::Request.new env
      response = Rack::Response.new

      if !request.params['user'].nil?
        reset_cookies request, response
        response.redirect '/game'
        return response.finish
      end

      @app.call env
    end
  end
end
