require './lib/rovos_client'

class RovosClient
  def self.build
    RovosClient.new ENV.fetch('rovos_broker_host', Rails.application.credentials[:rovos_broker_host])
  end
end
