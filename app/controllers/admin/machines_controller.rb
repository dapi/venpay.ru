class Admin::MachinesController < Admin::ApplicationController
  def index
  end

  def show
    render locals: {
      machine: machine,
      form: StartForm.new(time: 5)
    }
  end

  def status
    raise 'xhr only' unless request.xhr?

    result = RovosClient.build.post('/machines/' + machine.internal_id.to_s, state: 4)
    render locals: { result: result }, layout: false
  rescue Faraday::TimeoutError => error
    render :status_timeout, layout: false
  rescue Faraday::ClientError, RovosClient::Error => error
    render :status_error, locals: { error: error }, layout: false
  end

  private

  def machine
    @machine ||= available_machines.find params[:id]
  end
end
