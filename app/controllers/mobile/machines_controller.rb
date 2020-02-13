class Mobile::MachinesController < Mobile::ApplicationController
  # Форма выбора кресла
  #
  def new
    render locals: { form: SelectMachineForm.new }
  end

  # Выбор кресла
  def create
    form = SelectMachineForm.new params[:select_machine_form].permit!
    if form.valid?
      redirect_to machine_path form.machine
    else
      render :new, locals: { form: form }
    end
  end

  def status
    machine = Machine.find params[:id]
    result = RovosClient.build.post('/machines/' + machine.internal_id.to_s, state: 4)
    render locals: { machine: machine, result: result }
  end

  def show
    machine = params[:id].present? ? Machine.find(params[:id]) : Machine.find_by!(slug: params[:slug])
    prices = machine.account.prices.order('position desc')
    render locals: { account: machine.account, machine: machine, prices: prices }, layout: 'mobile'
  end
end
