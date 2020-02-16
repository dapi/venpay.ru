class Admin::PricesController < Admin::ApplicationController
  def index
    account = available_accounts.find params[:account_id]
    render locals: { account: account }
  end
end
