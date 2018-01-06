require './lib/codebreaker-web/index.rb'
require './lib/codebreaker-web/game.rb'
require './lib/codebreaker-web/guess.rb'
require './lib/codebreaker-web/lint.rb'

use Rack::Static, urls: ['/css'], root: 'public'

app = Rack::Builder.new do
  use Rack::CommonLogger
  use Rack::ShowExceptions
  use Rack::Lint

  map "/" do
    run CodebreakerWeb::Index
  end

  map "/game" do
    # use CodebreakerWeb::GameRunning
    run CodebreakerWeb::Game
  end

  map "/guess" do
    # use CodebreakerWeb::GameRunning
    run CodebreakerWeb::Guess
  end

  map "/lint" do
    # use CodebreakerWeb::GameRunning
    run CodebreakerWeb::Lint
  end
end

run app
