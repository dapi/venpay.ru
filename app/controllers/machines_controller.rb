class MachinesController < ApplicationController
  def index
  end

  def show
    machine = Machine.find params[:id]
    prices = machine.account.prices.order(:title)
    render locals: { machine: machine, prices: prices }
  end
end
