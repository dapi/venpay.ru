# frozen_string_literal: true

set :application, 'venpay.ru'
set :stage, :production
set :rails_env, :production
fetch(:default_env)[:rails_env] = :production

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

server 'venpay.ru',
       user: fetch(:user),
       port: '22',
       roles: %w[web app db bugsnag].freeze,
       ssh_options: { forward_agent: true }
