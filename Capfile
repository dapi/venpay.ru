# frozen_string_literal: true

require 'rubygems'
require 'bundler'
Bundler.setup(:deploy)

# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

require 'capistrano/scm/git-with-submodules'
install_plugin Capistrano::SCM::Git::WithSubmodules

require 'capistrano/rbenv'
require 'capistrano/nvm'
require 'capistrano/yarn'
require 'capistrano/bundler'
require 'capistrano-db-tasks'
require 'capistrano/shell'
require 'capistrano/puma'
install_plugin Capistrano::Puma

require 'capistrano/rails/assets'
require 'capistrano/faster_assets'
require 'capistrano/rails/migrations'
# require 'capistrano/sidekiq'

require 'capistrano/rails/console'
require 'capistrano/master_key'
