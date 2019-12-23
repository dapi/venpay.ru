module ApplicationHelper
  def qr_code_url(machine)
    QrCodeGenerator.for_machine(machine).qr_code_url
  end

  def humanized_machine(machine)
    "Кресло N#{machine.public_number} по адресу #{machine.location}"
  end

  def humenized_price(price)
    "#{price.title} за #{price.price.format}"
  end
end
