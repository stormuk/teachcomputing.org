module DashboardHelper
  def get_course_tag(achievement)
    if achievement&.cs_accelerator?
      'CS Accelerator'
    elsif achievement&.secondary_certificate?
      'Secondary certificate'
    elsif achievement&.primary_certificate?
      'Primary certificate'
    end
  end

  def get_course_suffix(achievement)
    get_course_tag(achievement)&.gsub(' certificate', '')&.parameterize
  end

  def get_date_string(achievement)
    if achievement.current_state == :complete.to_s
      "Completed on #{achievement.created_at.strftime('%b %Y')}"
    else
      "Enrolled on #{achievement.updated_at.strftime('%b %Y')}"
    end
  end
end
