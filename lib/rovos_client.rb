require 'net/http'
require 'uri'

# Клиент к rovos-брокеру
#
# Пример:
#
# rovos = RovosClient.new('http://localhost:8080', 'secret')
# rovos.post('/machines/100020003', state: 4)
class RovosClient
  OPEN_TIMEOUT = 2
  READ_TIMEOUT = 5

  def initialize(uri, secret_key=nil)
    @uri = URI(uri)
    @secret_key = secret_key
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
    header = { "X-Signature" => signature(params) }
    uri.path = path
    options = { open_timeout: OPEN_TIMEOUT, read_timeout: READ_TIMEOUT, use_ssl: uri.scheme == 'https' }
    response = Net::HTTP.start(uri.hostname, uri.port, options) do |http|
      http.post(uri, '', header)
    end
    validate_response! response, 201
    JSON.parse response.body
  end

  def get(path)
    # Параметр t не требуется сервером, однако использутся для того,
    # чтобы было из чего формировать подпись
    params = {t: Time.zone.now.to_i}
    header = { "X-Signature" => signature(params) }
    uri.path = path
    options = { open_timeout: OPEN_TIMEOUT, read_timeout: READ_TIMEOUT, use_ssl: uri.scheme == 'https' }
    response = Net::HTTP.start(uri.hostname, uri.port, options) do |http|
      http.get(uri, header)
    end
    validate_response! response, 200
    JSON.parse response.body
  end

  private

  attr_reader :uri, :secret_key

  CONTENT_TYPE = 'application/json'.freeze

  def validate_response!(response, code)
    raise "Wrong response code #{response.code}" unless response.code == code.to_s
    raise "Content-Type must be #{CONTENT_TYPE} (#{response.content_type})" unless response.content_type == CONTENT_TYPE
  end

  def signature(params)
    Digest::MD5.base64digest [params.sort_by(&:first).flatten, secret_key].join
  end
end
