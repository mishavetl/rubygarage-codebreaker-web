module CodebreakerWeb
  class OnlyGet
    def initialize(app)
      @app = app
    end

    def call(env)
      request = Rack::Request.new env

      if !request.get?
        response = Rack::Response.new 'Method not allowed', 405, {}
        return response.finish
      end

      @app.call env
    end
  end
end
