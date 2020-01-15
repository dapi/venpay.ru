class Admin::ApplicationController < ApplicationController
  before_action :require_login

  helper_method :available_accounts, :available_machines

  private

  def available_accounts
    current_user.accounts
  end

  def available_machines
    current_user.machines
  end
end
