require 'net/http'

# Клиент к rovos-брокеру
#
# Пример:
#
# rovos = RovosClient.new('http://localhost:8080', 'secret')
# rovos.post('/machines/100020003', state: 4)
class RovosClient
  OPEN_TIMEOUT = 2
  READ_TIMEOUT = 5
  HEADER = { 'User-Agent' => 'RovosClient (ruby) v0.1.0' }

  def initialize(host)
    @host = host
  end

  # @param params [HASH] {:state, :work_time}
  #
  # state:
  # 2 - включить
  # 4 - узнать статус
  #
  # Пример:
  #
  # post('/machines/100020003', state: 4)                # Узнать состояние
  # post('/machines/100020003', state: 2, work_time: 10) # Включить на 10 минут
  def post(path, params)
    response = connection.post path, params, HEADER
    validate_response! response, 201
    JSON.parse response.body
  end

  def get(path, params = {})
    response = connection.get path, params, HEADER
    validate_response! response, 200
    JSON.parse response.body
  end

  private

  attr_reader :host

  CONTENT_TYPE = 'application/json'.freeze

  def validate_response!(response, status)
    raise "Wrong response status #{response.status}" unless response.status == status
    content_type = response.headers['Content-Type']
    raise "Content-Type must be #{CONTENT_TYPE} (#{content_type})" unless content_type == CONTENT_TYPE
  end

  def client_cert
    OpenSSL::X509::Certificate.new File.read Rails.root.join('config/certs/broker.venpay.ru.pem')
  end

  def client_key
    OpenSSL::PKey.read File.read Rails.root.join('config/certs/broker.venpay.ru.key')
  end

  def connection
    @connection ||= Faraday.new host,
      request: { timeout: READ_TIMEOUT, open_timeout: OPEN_TIMEOUT },
      ssl: { client_cert:  client_cert, client_key: client_key, verify: false }
  end
end
