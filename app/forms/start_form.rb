class StartForm
  DEFAULT_TIME = 5

  include ActiveModel::Model

  attr_accessor :time

  def initialize(*args)
    self.time = DEFAULT_TIME
    super(*args)
  end
end
