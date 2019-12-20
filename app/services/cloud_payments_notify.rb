class CloudPaymentsNotify
  def initialize(payment:, payload: , hmac_token: )
    @payment = payment
    @payload = payload
    @hmac_token = hmac_token
  end

  def notify_success
    validate!
    payment.pay! payload: payload, hmac_token: hmac_token

    success_response
  rescue CloudPayments::Webhooks::HMACError => e
    Bugsnag.notify e
    fail_response
  end

  def notify_fail
    validate!
    payment.fail! payload: payload, hmac_token: hmac_token

    success_response
  rescue CloudPayments::Webhooks::HMACError => e
    Bugsnag.notify e
    fail_response
  end

  private

  attr_reader :payment, :payload, :hmac_token

  def validate!
    webhooks.validate_data! payload, hmac_token
  end

  def success_response
    { "code": 0 }
  end

  def fail_response
    'error'
  end

  def webhooks
    @webhooks ||= CloudPayments::Webhooks.new config
  end

  def config
    CloudPayments::Config.configure do |c|
      c.public_key = payment.account.cloud_payments_public_id
      c.secret_key = payment.account.cloud_payments_api_key
      c.logger = logger
      c.raise_banking_errors = true
    end
  end

  def logger
    @logger ||= ActiveSupport::Logger.new Rails.root.join('./log/cloud_payments.log')
  end
end