class Admin::MachinesController < Admin::ApplicationController
  def index
  end

  def edit
    render locals: { machine: machine }
  end

  def update
    machine.update params.require(:machine).permit!
    redirect_to admin_machine_path(machine)
  rescue ActiveRecord::RecordInvalid => err
    render :edit, locals: { machine: err.record }
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
end
