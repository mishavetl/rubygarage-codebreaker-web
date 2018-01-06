require './lib/codebreaker-web/view.rb'

module CodebreakerWeb
  class Game
    def self.call(env)
      request = Rack::Request.new env
      response = Rack::Response.new

      if !request.params['user'].nil?
        self.reset_cookies request, response
      end

      response.write render(request)
      response.finish
    end

    def self.reset_cookies(request, response)
      user = request.params['user']
      request.cookies['user'] = user
      response.set_cookie 'user', user
    end

    def self.render(request)
      cookies = request.cookies
      user = cookies['user']
      user ||= ''
      View::render('game.html.erb', binding)
    end
  end
end
