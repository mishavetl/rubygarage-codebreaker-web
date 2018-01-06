require './lib/codebreaker-web/view.rb'
require './lib/codebreaker-web/config.rb'

module CodebreakerWeb
  class StartGameIfUserGiven
    def initialize(app)
      @app = app
    end

    def reset_cookies(request, response)
      user = request.params['user']
      request.cookies['user'] = user
      request.cookies['attempts_left'] = Config.attempts_amount
      response.set_cookie 'user', user
      response.set_cookie 'attempts_left', Config.attempts_amount
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
