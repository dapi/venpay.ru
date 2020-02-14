class Admin::ActionsController < Admin::ApplicationController
  def create
    raise 'xhr only' unless request.xhr?
    machine = Machine.find params[:machine_id]
    form = StartForm.new params.fetch(:start_form).permit!
    machine.adapter.start form.time
    render locals: { machine: machine, message: 'Устройство запущено', form: StartForm.new }, layout: false
  rescue ApplicationAdapter::Error => error
    render locals: { machine: machine, message: error, form: form }, layout: false
  end
end
