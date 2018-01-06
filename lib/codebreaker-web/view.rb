require 'erb'
require './lib/codebreaker-web/version.rb'

module CodebreakerWeb
  class View
    def self.render(template, vars)
      path = File.expand_path("../../views/#{template}", __FILE__)
      ERB.new(File.read(path)).result(vars)
    end
  end
end
