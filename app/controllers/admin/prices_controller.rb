class Admin::PricesController < Admin::ApplicationController
  def index
    account = available_accounts.find params[:account_id]
    render locals: { account: account }
  end

  def edit
    render locals: { price: price }
  end

  def update
    price.update price_params
    flash_notice!
    redirect_to admin_prices_path(account_id: price.account_id)
  rescue ActiveRecord::RecordInvalid => err
    render :edit, locals: { price: err.record }
  end

  def new
    price = Price.new price_params
    render locals: { price: price }
  end

  def create
    account = available_accounts.find price_params[:account_id]
    price = account.prices.create! price_params
    flash_notice!
    redirect_to admin_prices_path(account_id: price.account_id)
  rescue ActiveRecord::RecordInvalid => err
    render :new, locals: { price: err.record }
  end

  def destroy
    price.destroy!
    flash_notice!
    redirect_to admin_prices_path(account_id: price.account_id)
  end

  private

  def price_params
    params.require(:price).permit!
  end

  def available_prices
    current_user.prices
  end

  def price
    @price ||= available_prices.find params[:id]
  end
end
