class ApplicationController < ActionController::Base
  include RescueErrors

  private

  def xhr_only?
    raise 'xhr only' unless request.xhr?
  end
end
