require './lib/rovos_client'

class RovosClient
  def self.build
    if ENV.has_key?('ROVOS_BROKER_HOST')
      RovosClient.new ENV.fetch('ROVOS_BROKER_HOST')
    else
      client_cert = OpenSSL::X509::Certificate.new File.read Rails.root.join('config/certs/broker.venpay.ru.pem')
      client_key = OpenSSL::PKey.read File.read Rails.root.join('config/certs/broker.venpay.ru.key')
      RovosClient.new(
        Rails.application.credentials[:rovos_broker_host],
        ssl: { client_cert:  client_cert, client_key: client_key, verify: false }
      )
    end
  end
end
