require './lib/codebreaker-web/view.rb'

module CodebreakerWeb
  class Guess
    def self.call(env)
      request = Rack::Request.new env
      response = Rack::Response.new

      cookies = request.cookies
      response.set_cookie('attempts_left', cookies['attempts_left'].to_i - 1)

      response.redirect '/game'
      response.finish
    end
  end
end
