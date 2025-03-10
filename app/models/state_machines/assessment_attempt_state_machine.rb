class StateMachines::AssessmentAttemptStateMachine
  include Statesman::Machine

  STATE_COMMENCED = :commenced
  STATE_PASSED = :passed
  STATE_FAILED = :failed

  state STATE_COMMENCED, initial: true
  state STATE_PASSED
  state STATE_FAILED

  transition from: STATE_COMMENCED, to: STATE_PASSED
  transition from: STATE_COMMENCED, to: STATE_FAILED

  after_transition(to: :failed) do |assessment_attempt|
    FailedAssessmentEmailJob.perform_later(assessment_attempt.user_id)
  end
end
