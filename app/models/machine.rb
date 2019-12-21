require 'securerandom'

class Machine < ApplicationRecord
  belongs_to :account

  validates :internal_id, presence: true, uniqueness: true
  validates :public_number, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  before_validation on: :create do
    self.slug ||= SecureRandom.hex(3)
  end

  after_commit on: :create do
    QrCodeGenerator.for_machine(self).generate_svg
  end
end
