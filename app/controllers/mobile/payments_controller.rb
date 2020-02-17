class Mobile::PaymentsController < Mobile::ApplicationController
  include AutoLogger

  def show
    if payment.paid?
      # TODO Убедиться что по этому платежу машину включали,если нет, то запустить процесс включения
      render :success, locals: { payment: payment }
    else
      render locals: { payment: payment }
    end
  end

  def create
    payment = Payment.create! permitted_params

    logger.info "Create CloudPayments payment #{payment.id} for machine #{payment.machine.public_number} with #{payment.price.title}"
    redirect_to payment_path(payment)
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:error] = e.message
    Bugsnag.notify e

    redirect_back fallback: machines_path
  end

  def success
    render locals: { payment: payment }
  end

  def fail
    # nothing yet
  end

  private

  def payments
    @payment ||= Payment.find params[:id]
  end

  def permitted_params
    params.permit(:machine_id, :price_id)
  end
end
