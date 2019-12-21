if defined? HttpLog
  puts 'Log outgoing HTTP requests in ruby'
  puts 'Включаю HttpLog в ./log/http_outcome.log'
  HttpLog.configure do |config|
    config.enabled = true
    config.log_request   = true
    config.log_headers   = true
    config.logger = ActiveSupport::Logger.new Rails.root.join("./log/http_outcome.log")
  end
end
