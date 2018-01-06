require './lib/codebreaker-web/view.rb'

module CodebreakerWeb
  class Lint
    def self.call(env)
      # request = Rack::Request.new env
      response = Rack::Response.new

      # if request.post?
      #   self.post request, response
      # end

      # response.write render(request)
      # response.finish

      response.write 'not implemented'
      response.finish
    end

    def self.post(request, response)
      user = request.params['user']
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
