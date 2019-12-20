# frozen_string_literal: true

set :application, 'venpay.ru'
set :stage, :production
set :rails_env, :production
fetch(:default_env)[:rails_env] = :production

server 'venpay.ru',
       user: fetch(:user),
       port: '22',
       roles: %w[sidekiq web app db bugsnag].freeze,
       ssh_options: { forward_agent: true }
