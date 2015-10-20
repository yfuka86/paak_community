lock '3.4.0'

set :application, 'paak_community'
set :repo_url, 'git@github.com:yfuka86/paak_community.git'
set :user, "deploy"
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

set :linked_files, %w{config/database.yml}

set :ssh_options, {
  keys: [File.expand_path('~/.ssh/id_rsa')],
  forward_agent: true,
  port: 7231
}

set :rbenv_type, :user
set :rbenv_ruby, '2.2.2'

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all
