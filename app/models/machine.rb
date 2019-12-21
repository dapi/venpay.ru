class Machine < ApplicationRecord
  belongs_to :account

  validates :internal_id, presence: true, uniqueness: true
  validates :public_number, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
end
