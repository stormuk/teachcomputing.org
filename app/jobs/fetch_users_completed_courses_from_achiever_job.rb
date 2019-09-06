class FetchUsersCompletedCoursesFromAchieverJob < ApplicationJob
  queue_as :default

  def perform(user)
    courses = Achiever::Course::Delegate.find_by_achiever_contact_number(user.stem_achiever_contact_no)
    courses.each do |course|
      begin
        activity = Activity.find_by!(stem_course_id: course.course_template_no)
      rescue ActiveRecord::RecordNotFound => e
        Raven.tags_context(stem_course_id: course.course_template_no, user_id: user.id)
        Raven.capture_exception(e)
        next
      end
      achievement = Achievement.find_or_create_by(activity_id: activity.id, user_id: user.id) do |achievement|
        achievement.activity_id = activity.id
        achievement.user_id = user.id
      end
      achievement.set_to_complete if course.is_fully_attended
    end
  end
end
