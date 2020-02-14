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
end
