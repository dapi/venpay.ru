class Activity < ApplicationRecord
  belongs_to :machine

  validates :message, presence: true
end
