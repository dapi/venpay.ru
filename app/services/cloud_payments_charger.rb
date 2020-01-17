class CloudPaymentsCharger
  URL = 'https://api.cloudpayments.ru/payments/cards/charge'

  def initialize(payemnt:, client_name: , client_ip: , card_cryptogram_packet:)
    @oayment = payment
    @card_cryptogram_packet = card_cryptogram_packet
    @client_name = client_name
    @client_ip = client_ip
  end

  def perform
    response = JSON.parse(Faraday.post(url, params).body)

    errors_check! response


  end

  private

  attr_reader :payment, :client_name, :card_cryptogram_packet, :client_ip

  def params
    {
      Amount: payment.total_price.to_f,
      Currency: payment.total_price_currency.to_s,
      IpAddress: client_ip,
      Name: client_name,
      CardCryptogramPacket: card_cryptogram_packet
      InvoiceId: payment.id
      Description: payment.title
    }
  end
end