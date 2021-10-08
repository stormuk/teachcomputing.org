module CSAccelerator
  class CheckNextStepsJob < ApplicationJob
    queue_as :default

    def perform(achievement_id)
      achievement = Achievement.find(achievement_id)
      user = achievement.user

      return unless Programme.cs_accelerator.user_enrolled?(user)

      case achievement.activity.category
      when 'online'
        AchievementMailer.with(user_id: user.id).completed_online_course.deliver_now
      when 'face-to-face'
        AchievementMailer.with(user_id: user.id).completed_face_to_face_course.deliver_now
      end
    end
  end
end
