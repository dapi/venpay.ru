require 'securerandom'

class Machine < ApplicationRecord
  AVAILABLE_ADAPTERS = [RovosAdapter, SmsAdapter]

  belongs_to :account

  validates :internal_id, presence: true, uniqueness: true
  validates :public_number, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
  validates :adapter_class, presence: true, inclusion: { in: AVAILABLE_ADAPTERS.map(&:to_s) }

  before_validation on: :create do
    self.slug ||= SecureRandom.hex(3)
  end

  after_commit on: :create do
    QrCodeGenerator.for_machine(self).generate_svg
  end

  def adapter
    adapter_class
      .constantize
      .new(self)
  end
end
