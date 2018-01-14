require 'codebreaker-web/view'

module CodebreakerWeb
  class Statistics
    def self.call(env)
      request = Rack::Request.new(env)
      response = Rack::Response.new
      cookies = request.cookies
      user = cookies['user']
      user ||= ''
      raw_statistics = cookies['statistics'] || '[]'
      statistics = JSON.parse raw_statistics
      response.write View::render('statistics.html.erb', binding)
      response.finish
    end
  end
end
