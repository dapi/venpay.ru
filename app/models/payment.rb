class Payment < ApplicationRecord
  include PaymentState

  belongs_to :machine
  belongs_to :price

  monetize :total_price_cents, allow_nil: true

  delegate :account, to: :machine

  before_validation do
    self.total_price = price.price
    self.title = 'Оплата ' + total_price.format
  end

  private

  def pay(payload: , hmac_token:)
    update! payload: payload, hmac_token: hmac_token
  end

  def fail(payload: , hmac_token:)
    update! payload: payload, hmac_token: hmac_token
  end
end