require './lib/codebreaker-web/view.rb'
require './lib/codebreaker-web/config.rb'

module CodebreakerWeb
  class Game
    def self.call(env)
      request = Rack::Request.new env
      response = Rack::Response.new

      response.write render(request)
      response.finish
    end

    def self.render(request)
      cookies = request.cookies
      user = cookies['user']
      user ||= ''
      attempts_left = cookies['attempts_left']
      attempts_left ||= ''
      attempts_amount = Config.attempts_amount
      View::render('game.html.erb', binding)
    end
  end
end
