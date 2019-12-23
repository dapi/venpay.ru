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
    response = RovosClient.build.post("/machines/#{payment.machine.internal_id}", state: 2, work_time: payment.price.work_time)
    logger.info "RovosClient response #{response}"
    render json: result
  end

  def fail
    result = CloudPaymentsNotify.new(
      payment: payment,
      payload: request.body.read,
      hmac_token: request.headers['Content-Hmac']
    ).notify_fail

    logger.info "CloudPayments fail #{result}"
    render json: result
  end

  private

  def payment
    @payment ||= Payment.find params[:InvoiceId]
  end
end
