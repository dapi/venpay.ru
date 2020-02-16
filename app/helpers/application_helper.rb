module ApplicationHelper
  def app_title
    'VENPAY'
  end

  def payment_state_label(state)
    case state
    when 'new' then content_tag(:span, 'Ожидание оплаты', class: 'badge badge-warning')
    when 'paid' then content_tag(:span, 'Оплачен', class: 'badge badge-success')
    when 'failed' then content_tag(:span, 'Оплата не удалась', class: 'badge badge-danger')
    else
      content_tag(:span, "Неизвестный статус #{state}")
    end
  end

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

  def humanized_state(result)
    r = result['received']

    buffer = []
    buffer << "Включено на #{r['work_time']} мин." if r['work_time'].to_i > 0
    buffer << "Осталось #{r['time_left']} сек." if r['time_left'].to_i > 0
    msecs = (r['last_activity_elapsed'].to_f * 1000).to_i
    buffer << "На связи (#{msecs} ms)"

    content_tag :span, buffer.join(', '), class: 'badge badge-success'
  end

  def home_button
    link_to 'Вернуться в начало', root_path, class: 'btn btn-outline-secondary mt-4'
  end
end
