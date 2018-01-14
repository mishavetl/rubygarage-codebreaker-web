require 'codebreaker-web/view'

module CodebreakerWeb
  class Won
    def self.call(env)
      request = Rack::Request.new(env)
      response = Rack::Response.new
      cookies = request.cookies
      user = cookies['user']
      user ||= ''
      score = cookies['attempts_left'].to_i + 1
      response.write View::render('won.html.erb', binding)
      response.finish
    end
  end
end
