class StateMachines::AchievementStateMachine
  include Statesman::Machine

  state :enrolled, initial: true
  state :in_progress
  state :complete
  state :dropped

  transition from: :enrolled, to: %i[in_progress complete dropped]
  transition from: :in_progress, to: %i[complete dropped]
  transition from: :dropped, to: %i[enrolled complete in_progress]
end
