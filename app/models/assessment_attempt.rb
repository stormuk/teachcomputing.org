class AssessmentAttempt < ApplicationRecord
  include Statesman::Adapters::ActiveRecordQueries
  belongs_to :user
  belongs_to :assessment

  has_many :assessment_attempt_transitions, autosave: false, dependent: :destroy

  scope :for_user, ->(user) {
    where(user_id: user.id).order(:created_at)
  }

  def state_machine
    @state_machine ||= StateMachines::AssessmentAttemptStateMachine.new(self, transition_class: AssessmentAttemptTransition)
  end

  def self.transition_class
    AssessmentAttemptTransition
  end

  def self.initial_state
    StateMachines::AssessmentAttemptStateMachine.initial_state
  end
  private_class_method :initial_state

  delegate :can_transition_to?, :current_state, :transition_to, :last_transition, to: :state_machine
end
