class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :memberships
  has_many :accounts, through: :memberships

  validates :email, presence: true, uniqueness: true
end
