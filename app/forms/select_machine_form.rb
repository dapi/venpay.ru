class SelectMachineForm
  include ActiveModel::Model

  attr_accessor :machine_number

  validates :machine_number, presence: true
  validate :machine_exists

  def machine
    @machine ||= Machine.find_by public_number: machine_number.to_s.gsub(/\D/,'')
  end

  private

  def machine_exists
    errors.add :machine_number, 'Неверный номер' if machine.nil?
  end
end
