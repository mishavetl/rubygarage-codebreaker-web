module CodebreakerWeb
  class OnlyGet
    def initialize(app)
      @app = app
    end

    def call(env)
      request = Rack::Request.new env

      if !request.get?
        return Rack::Response.new 'Method not allowed', 405, {}
      end

      @app.call env
    end
  end
end
