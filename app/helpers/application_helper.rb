module ApplicationHelper
  def qr_code_url(machine)
    QrCodeGenerator.for_machine(machine).qr_code_url
  end
end
