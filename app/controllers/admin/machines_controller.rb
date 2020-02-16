class Admin::MachinesController < Admin::ApplicationController
  def index
  end

  def edit
    render locals: { machine: machine }
  end

  def update
    machine.update machine_params
    flash_notice!
    redirect_to admin_machine_path(machine)
  rescue ActiveRecord::RecordInvalid => err
    render :edit, locals: { machine: err.record }
  end

  def new
    account = available_accounts.find machine_params[:account_id]
    render locals: { machine: account.machines.build }
  end

  def create
    machine = account.machines.create! machine_params
    flash_notice!
    redirect_to admin_machine_path(machine)
  rescue ActiveRecord::RecordInvalid => err
    render :new, locals: { machine: err.record }
  end

  def destroy
    machine.destroy!
    flash_notice!
    redirect_to admin_machines_path
  end

  def show
    render locals: { machine: machine, form: StartForm.new }
  end

  def status
    raise 'xhr only' unless request.xhr?
    result = machine.adapter.status
    render locals: { result: result }, layout: false
  rescue ApplicationAdapter::Error => error
    render :status_error, locals: { error: error }, layout: false
  end

  private

  def machine
    @machine ||= available_machines.find params[:id]
  end

  def machine_params
    params.require(:machine).permit!
  end

  def account
    @account ||= available_accounts.find machine_params[:account_id]
  end
end
