require 'json'

require 'codebreaker-web/view'
require 'codebreaker-web/config'

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
      attempts = getAttempts cookies
      last_hint = cookies['last_hint']
      View::render('game.html.erb', binding)
    end

    def self.getAttempts(cookies)
      attemptsSrc = cookies['attempts'] || ''
      JSON.parse attemptsSrc
    end
  end
end
