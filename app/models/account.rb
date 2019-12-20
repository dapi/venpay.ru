class Account < ApplicationRecord
  validates :title, presence: true, uniqueness: true
end
