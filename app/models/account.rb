class Account < ApplicationRecord
  has_many :machines
  validates :title, presence: true, uniqueness: true
end
