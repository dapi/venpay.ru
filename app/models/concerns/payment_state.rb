module PaymentState
  extend ActiveSupport::Concern

  STATE_AWAIT    = 'new'.freeze
  STATE_FAILED   = 'failed'.freeze
  STATE_PAID     = 'paid'.freeze

  included do
    include Workflow

    workflow_column :state

    workflow do
      state STATE_AWAIT do
        event :pay,    transitions_to: STATE_PAID
        event :fail,   transitions_to: STATE_FAILED
      end
      state STATE_FAILED do
        event :pay,    transitions_to: STATE_PAID
        event :fail,   transitions_to: STATE_FAILED
      end
      state STATE_PAID do
        event :pay,    transitions_to: STATE_PAID
      end
    end
  end
end