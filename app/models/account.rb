class Account < ApplicationRecord
  has_many :machines
  has_many :prices

  attr_encrypted :cloud_payments_api_key, key: Rails.application.credentials.secret_key_base.first(32)

  validates :title, presence: true, uniqueness: true
end
