# frozen_string_literal: true

set :application, 'venpay.ru'
set :stage, :production
set :rails_env, :production
fetch(:default_env)[:rails_env] = :production

server '95.217.36.54',
       user: fetch(:user),
       port: '22',
       roles: %w[sidekiq web app db bugsnag].freeze,
       ssh_options: { forward_agent: true }
