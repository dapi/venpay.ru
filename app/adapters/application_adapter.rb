class ApplicationAdapter
  Error = Class.new StandardError

  def initialize(machine)
    @machine = machine
  end

  def start(time)
  end

  def status
    # do nothing
  end

  private

  attr_reader :machine

  def log_success_acitity(time)
    machine.activities.create message: "Старт на #{time}"
  end

  def log_failed_acivity(time, error)
    machine.activities.create message: "Провалился старт на #{time} с ошибков #{error}"
  end
end
