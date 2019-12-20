class PaymentsController < ApplicationController
  def show
    payment = Payment.find params[:id]

    if payment.paid?
      render :success
    else
      render locals: { payment: payment }
    end
  end

  def create
    payment = Payment.create! permitted_params

    redirect_to payment_path(payment)
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:error] = e.message

    redirect_back fallback: machines_path
  end

  def success
  end

  def fail
  end

  private

  def permitted_params
    params.permit(:machine_id, :price_id)
  end
end