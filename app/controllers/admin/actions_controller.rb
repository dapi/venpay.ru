class Admin::ActionsController < Admin::ApplicationController
  def create
    machine = Machine.find params[:machine_id]
    result = RovosClient.build.post('/machines/' + machine.internal_id.to_s, state: 2, work_time: params.fetch(:start_form).fetch(:time))
    render 'admin/machines/show', locals: {
      machine: machine,
      result:  result,
      form:    StartForm.new(time: 5)
    }
  end
end
