# Подписыватель запросов к брокеру
module Signatory
  def self.sign(params, secret_key)
    Digest::MD5.base64digest [params.sort_by(&:first).flatten, secret_key].join
  end
end
