class FetchUsersCompletedCoursesFromAchieverJob < ApplicationJob
  queue_as :default

  def perform(user)
    courses = DelegateCourseList.from_achiever(user.stem_achiever_contact_no)
    completed_courses = courses.select { |delegate_course| delegate_course.delegate_is_fully_attended == '1' }
    completed_courses.each do |course|
      begin
        activity = Activity.find_by!(course_id: course.course_template_no)
      rescue ActiveRecord::RecordNotFound => e
        Raven.tags_context(course_id: course.course_template_no, user_id: user.id)
        Raven.capture_exception(e)
        next
      end
      record = Achievement.find_or_create_by(activity_id: activity.id, user_id: user.id) do |achievement|
        achievement.activity_id = activity.id
        achievement.user_id = user.id
      end

      record.transition_to(:complete, credit: record.activity.credit)
    end
  end
end
