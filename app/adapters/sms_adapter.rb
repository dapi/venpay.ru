class SmsAdapter < ApplicationAdapter
  def status
    # imposible to get it
  end

  def start(time)
    raise ApplicationAdapter::Error, 'Phone must be presene' if machine.phone.blank?
    SmsService.call(machine.phone)
  end
end
