require 'codebreaker-web/view'

module CodebreakerWeb
  class Index
    def self.call(env)
      request = Rack::Request.new(env)
      response = Rack::Response.new
      cookies = request.cookies
      user = cookies['user']
      user ||= ''
      response.write View::render('index.html.erb', binding)
      response.finish
    end
  end
end
