require 'net/http'

# Клиент к rovos-брокеру
#
# Пример:
#
# rovos = RovosClient.new('http://localhost:8080', 'secret')
# rovos.post('/machines/100020003', state: 4)
class RovosClient
  OPEN_TIMEOUT = 1
  READ_TIMEOUT = 1
  HEADER = { 'User-Agent' => 'RovosClient (ruby) v0.1.0' }

  Error = Class.new StandardError
  NotFound = Class.new Error

  def initialize(host, ssl: {})
    @host = host
    @ssl = ssl
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

  CONTENT_TYPE = 'application/json'.freeze

  def validate_response!(response, status)
    unless response.status == status
      if response.status == 404
        raise NotFound, 'Not found'
      else
        raise Error, "Wrong response status #{response.status}"
      end
    end
    content_type = response.headers['Content-Type']
    raise "Content-Type must be #{CONTENT_TYPE} (#{content_type})" unless content_type == CONTENT_TYPE
  end

  def connection
    @connection ||= Faraday.new @host,
      request: { timeout: READ_TIMEOUT, open_timeout: OPEN_TIMEOUT },
      ssl: @ssl
  end
end
