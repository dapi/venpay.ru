Bugsnag.configure do |config|
  config.api_key = "2bb3ad8fb746749e9ac62d60a42bcafc"
  config.app_version = AppVersion.format('%M.%m.%p') # rubocop:disable Style/FormatStringToken
  config.send_code = true
  config.send_environment = true
end
