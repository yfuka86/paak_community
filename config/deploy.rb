lock '3.4.0'

set :application, 'paak_community'
set :repo_url, 'git@github.com:yfuka86/paak_community.git'
set :user, "deploy"
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

set :ssh_options, {
  keys: [File.expand_path('~/.ssh/id_rsa')],
  forward_agent: true,
  port: 7231
}

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
    on roles(:web) do
      execute :sudo, "apt-get -y update"
      execute :sudo, "apt-get -y upgrade --show-upgraded"
      execute :sudo, "apt-get -y install libxslt-dev libxml2-dev"
      execute :sudo, "apt-get -y install libdjvulibre-dev libjpeg-dev libtiff-dev libwmf-dev libmagickcore-dev libmagickwand-dev libmagick++-dev"
      execute :sudo, "apt-get -y install imagemagick"
      execute :sudo, "apt-get -y install libcurl4-openssl-dev libffi-dev"
      execute :sudo, "apt-get -y install libav-tools"
    end
  end
end

set :ruby_version, "2.2.2"
set :rbenv_bootstrap, "bootstrap-ubuntu-12-04"

namespace :rbenv do
  desc "Install rbenv, Ruby, and the Bundler gem"
  task :install do
    on roles(:app) do
      execute :sudo, "apt-get -y install curl git-core"
      execute "curl -L https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash"
      bashrc = <<-BASHRC
export RBENV_ROOT="${HOME}/.rbenv"
if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init -)"
fi
BASHRC
      bashrc = StringIO.new(bashrc)
      upload! bashrc, "/tmp/rbenvrc"
      execute "cat /tmp/rbenvrc ~/.bashrc > ~/.bashrc.tmp"
      execute "mv ~/.bashrc.tmp ~/.bashrc"
      execute %q{export PATH="$HOME/.rbenv/bin:$PATH"}
      execute %q{eval "$(rbenv init -)"}
      execute "rbenv #{fetch(:rbenv_bootstrap)}"
      execute "rbenv install #{fetch(:ruby_version)}"
      execute "rbenv global #{fetch(:ruby_version)}"
      execute "gem install bundler --no-ri --no-rdoc"
      execute "rbenv rehash"
    end
  end
  after "deploy:install", "rbenv:install"
end

namespace :postgresql do
  desc "Install the latest stable release of PostgreSQL."
  task :install do
    on roles(:app), only: {primary: true} do
      execute :sudo, "apt-get -y update"
      execute :sudo, "apt-get -y install postgresql libpq-dev"
    end
  end
  after "deploy:install", "postgresql:install"
end
