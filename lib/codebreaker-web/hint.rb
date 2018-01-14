require './lib/codebreaker-web/view.rb'

module CodebreakerWeb
  class Hint
    def self.call(env)
      request = Rack::Request.new env
      response = Rack::Response.new

      cookies = request.cookies

      code = cookies['code']
      hints = cookies['hints']

      game = Codebreaker::Game.new
      game.start 1
      game.instance_variable_set('@code', code)
      game.instance_variable_set('@hints', hints.to_i)

      response.set_cookie('last_hint', game.hint)
      response.set_cookie('hints', game.instance_variable_get('@hints'))

      response.redirect '/game'
      response.finish
    end
  end
end
