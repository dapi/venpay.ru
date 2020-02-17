#
# Принимает от сервера CloudPayments запросы об успехе в оплате.
# URL к этому контроллеру прописывается как Callback URL в настройках CloudPayments
#
# TODO Переименовать в CloudPayments::Notifications
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
