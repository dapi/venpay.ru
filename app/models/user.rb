class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :memberships
  has_many :accounts, through: :memberships
  has_many :machines, through: :accounts

  validates :email, presence: true, uniqueness: true
end
