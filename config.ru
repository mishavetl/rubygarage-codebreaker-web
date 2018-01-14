require './lib/codebreaker-web/index.rb'
require './lib/codebreaker-web/game.rb'
require './lib/codebreaker-web/guess.rb'
require './lib/codebreaker-web/hint.rb'
require './lib/codebreaker-web/only_get.rb'
require './lib/codebreaker-web/only_post.rb'
require './lib/codebreaker-web/game_running.rb'
require './lib/codebreaker-web/end.rb'
require './lib/codebreaker-web/won.rb'
require './lib/codebreaker-web/statistics.rb'
require './lib/codebreaker-web/start_game_if_user_given.rb'

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
    use CodebreakerWeb::StartGameIfUserGiven
    use CodebreakerWeb::GameRunning
    run CodebreakerWeb::Game
  end

  map "/guess" do
    use CodebreakerWeb::OnlyPost
    use CodebreakerWeb::GameRunning
    run CodebreakerWeb::Guess
  end

  map "/hint" do
    use CodebreakerWeb::OnlyPost
    use CodebreakerWeb::GameRunning
    run CodebreakerWeb::Hint
  end

  map "/statistics" do
    use CodebreakerWeb::OnlyGet
    run CodebreakerWeb::Statistics
  end

  map "/end" do
    use CodebreakerWeb::OnlyGet
    run CodebreakerWeb::End
  end

  map "/won" do
    use CodebreakerWeb::OnlyGet
    run CodebreakerWeb::Won
  end
end

run app
