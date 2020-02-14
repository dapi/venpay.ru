class Admin::MachinesController < Admin::ApplicationController
  def index
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
