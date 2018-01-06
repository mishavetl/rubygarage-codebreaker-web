require './lib/codebreaker-web/index.rb'
require './lib/codebreaker-web/game.rb'
require './lib/codebreaker-web/guess.rb'
require './lib/codebreaker-web/lint.rb'
require './lib/codebreaker-web/only_get.rb'
require './lib/codebreaker-web/only_post.rb'

use Rack::Static, urls: ['/css'], root: 'public'

app = Rack::Builder.new do
  use Rack::CommonLogger
  use Rack::ShowExceptions
  use Rack::Lint

  map "/" do
    use CodebreakerWeb::OnlyGet
    run CodebreakerWeb::Index
  end

  map "/game" do
    use CodebreakerWeb::OnlyGet
    # use CodebreakerWeb::GameRunning
    run CodebreakerWeb::Game
  end

  map "/guess" do
    use CodebreakerWeb::OnlyPost
    # use CodebreakerWeb::GameRunning
    run CodebreakerWeb::Guess
  end

  map "/lint" do
    use CodebreakerWeb::OnlyPost
    # use CodebreakerWeb::GameRunning
    run CodebreakerWeb::Lint
  end
end

run app
