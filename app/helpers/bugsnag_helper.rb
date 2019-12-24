module BugsnagHelper
  def bugsnag_options
    {
      apiKey:       Settings.front_bugsnag_api_key,
      appVersion:   Bugsnag.configuration.app_version,
      releaseStage: Rails.env
    }
  end

  def bugsnag_user
    {}
  end
end
