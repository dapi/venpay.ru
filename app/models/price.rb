class Price < ApplicationRecord
  belongs_to :account

  monetize :price_cents, allow_nil: true

  validates :title, uniqueness: { scope: :account_id }, presence: true
  validates :price, presence: true
end
