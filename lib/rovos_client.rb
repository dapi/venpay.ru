require 'net/http'
require 'uri'

# Клиент к rovos-брокеру
class RovosClient
  def initialize(uri, secret=nil)
    @uri = URI(uri)
    @secret = secret
  end

  # 2 - включить
  # 4 - узнать статус
  #
  # Пример:
  #
  # RovosClient.new('http://localhost:8080/machines/100020003').post(state: 4)
  def post(state:, work_time: 0)
    response = Net::HTTP.post @uri, ''
    raise "Wrong response code #{response.code}" unless response.code == '201'
    JSON.parse response.body
  end
end
