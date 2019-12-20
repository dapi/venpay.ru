class Account < ApplicationRecord
  has_many :machines
  has_many :prices

  validates :title, presence: true, uniqueness: true
end
