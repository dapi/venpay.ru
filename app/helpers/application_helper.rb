module ApplicationHelper
  def qr_code_url(machine)
    QrCodeGenerator.for_machine(machine).qr_code_url
  end

  def humanized_machine(machine)
    "Кресло N#{machine.public_number} по адресу #{machine.location}"
  end

  def humanized_price(price)
    "#{price.title} за #{price.price.format}"
  end

  def public_number(pn)
    "№#{pn[0,3]}-#{pn[3,3]}"
  end
end
