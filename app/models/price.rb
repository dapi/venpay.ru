class Price < ApplicationRecord
  belongs_to :account

  monetize :price_cents, allow_nil: true

  validates :title, uniqueness: { scope: :account_id }, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 }
  validates :work_time, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 60 }
end
