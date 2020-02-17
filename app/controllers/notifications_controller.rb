class NotificationsController < ApplicationController
  include AutoLogger

  skip_before_action :verify_authenticity_token

  def success
    result = CloudPaymentsNotify.new(
      payment: payment,
      payload: request.body.read,
      hmac_token: request.headers['Content-Hmac']
    ).notify_success

    logger.info "CloudPayments success #{result}"
    response = payment.machine.adapter.start payment.work_time
    logger.info "Agent response #{response}"
    machine.activities.create message: "CloudPayments success callback"
    render json: result
  end

  def fail
    result = CloudPaymentsNotify.new(
      payment: payment,
      payload: request.body.read,
      hmac_token: request.headers['Content-Hmac']
    ).notify_fail

    logger.info "CloudPayments fail #{result}"
    machine.activities.create message: "CloudPayments fail callback"
    render json: result
  end

  private

  def payment
    @payment ||= Payment.find params[:InvoiceId]
  end
end
