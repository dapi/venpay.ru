# frozen_string_literal: true

module RescueErrors
  extend ActiveSupport::Concern

  LAYOUT = 'simple'

  included do
    # Examples:
    # rescue_from ActionController::UnknownFormat,     with: :rescue_unknown_format
    # rescue_from Authority::SecurityViolation,        with: :rescue_security_violation
    # rescue_from NotAuthenticated,                    with: :not_authenticated
    # rescue_from HumanizedError,                      with: :handle_humanized_error
    #
    rescue_from ActionController::MissingFile,       with: :not_found
    rescue_from ActiveRecord::RecordNotFound,        with: :not_found
    rescue_from ActionController::InvalidAuthenticityToken, with: :rescue_invalid_authenticity_token
    rescue_from ApplicationAdapter::Error,           with: :rescue_error
  end

  private

  def rescue_error(exception)
    Bugsnag.notify exception do |b|
      b.severity = :warning
    end
    render 'exception', locals: { exception: exception }, layout: LAYOUT
  end

  def rescue_security_violation(exception)
    return render_json_exception exception, status: :forbidden if request.format.json?

    render 'not_authorized', locals: { exception: exception }, layout: LAYOUT, status: :forbidden
  end

  def rescue_invalid_authenticity_token(_exception)
    render 'sessions/new', locals: {
      user_session: UserSession.new,
      message: t('helpers.invalid_authenticity_token')
    }, layout: LAYOUT
  end

  def render_json_exception(exception, status: :unprocessable_entity)
    render json: [exception.message], status: status
  end

  def not_found(_exception = nil)
    if request.format.html?
      render 'not_found', status: :not_found, layout: LAYOUT, formats: [:html]
    else
      render plain: 'not found', status: :not_found, layout: nil, formats: [:text]
    end
  end

  def not_authenticated(exception = nil)
    if request.format.json?
      if exception.present?
        render_json_exception exception, status: :forbidden
      else
        render json: { status: :forbidden }, status: :forbidden
      end
    else
      render 'sessions/new', locals: { user_session: UserSession.new, message: t('flashes.not_authenticated') },
                             status: :unauthorized,
                             layout: LAYOUT
    end
  end
end
