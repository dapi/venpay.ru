class SmsAdapter < ApplicationAdapter
  def status
    # imposible to get it
  end

  def start(time)
    SmsService.call(machine.phone)
  end
end
