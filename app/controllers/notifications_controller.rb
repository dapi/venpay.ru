class NotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def success
    result = CloudPaymentsNotify.new(
      payment: payment, 
      payload: request.body.read, 
      hmac_token: requset.headers['Content-Hmac']
    ).notify_success

    render json: result
  end

  def fail
    result = CloudPaymentsNotify.new(
      payment: payment, 
      payload: request.body.read, 
      hmac_token: request.headers['Content-Hmac']
    ).notify_fail

    render json: result
  end

  private

  def payment
    @payment ||= Payment.find params[:InvoiceId]
  end
end