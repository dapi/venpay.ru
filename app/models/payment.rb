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
end