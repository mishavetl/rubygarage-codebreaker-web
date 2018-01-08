require 'codebreaker-web/view'

module CodebreakerWeb
  class GameRunning
    def initialize(app)
      @app = app
    end

    def call(env)
      request = Rack::Request.new env
      attempts_left = request.cookies['attempts_left']
      attempts_left ||= 0
      attempts_left = attempts_left.to_i

      if attempts_left <= 0
        response = Rack::Response.new
        response.redirect '/end'
        return response.finish
      end

      @app.call env
    end
  end
end
