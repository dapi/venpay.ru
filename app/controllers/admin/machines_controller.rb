class Admin::MachinesController < Admin::ApplicationController
  def index
  end

  def status
    machine = Machine.find params[:id]
    result = RovosClient.build.post('/machines/' + machine.internal_id.to_s, state: 4)
    render locals: { machine: machine, result: result }
  end
end
