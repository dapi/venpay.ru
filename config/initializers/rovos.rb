require './lib/rovos_client'

class RovosClient
  def self.build
    RovosClient.new('http://localhost:8080', 'secret')
  end
end
