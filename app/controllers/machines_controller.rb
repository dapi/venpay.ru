class MachinesController < ApplicationController
  def index
  end

  def status
    machine = Machine.find params[:id]
    result = RovosClient.build.post('/machines/' + machine.internal_id.to_s, state: 4)
    render locals: { machine: machine, result: result }
  end

  def show
    machine = params[:id].present? ? Machine.find(params[:id]) : Machine.find_by!(slug: params[:slug])
    prices = machine.account.prices.order(:title)
    render locals: { account: machine.account, machine: machine, prices: prices }, layout: 'mobile'
  end
end
