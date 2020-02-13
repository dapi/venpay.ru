class Admin::ActionsController < Admin::ApplicationController
  def create
    raise 'xhr only' unless request.xhr?
    machine = Machine.find params[:machine_id]
    form = StartForm.new params.fetch(:start_form).permit!
    RovosClient
      .build
      .post('/machines/' + machine.internal_id.to_s,
            state: 2,
            work_time: form.time)

    render locals: { machine: machine, message: 'Устройство запущено', form: StartForm.new }, layout: false
  rescue Faraday::TimeoutError, Faraday::ClientError, RovosClient::Error => error
    render locals: { machine: machine, message: error, form: form }, layout: false
  end
end
