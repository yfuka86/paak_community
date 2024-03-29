set :branch, 'master'

set :stage, :production
set :rails_env, :production

set :db_host, 'localhost'

set :bundle_binstubs, nil
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/shared}

set :nginx_server_name, '.techlabpaak.org'

server '139.162.23.243', user: fetch(:user), roles: %w{web app db}, primary: true
