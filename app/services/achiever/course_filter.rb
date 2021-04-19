module Achiever
  class CourseFilter
    attr_reader :subjects, :age_groups

    def initialize(filter_params:)
      @filter_params = filter_params
      @subjects ||= Achiever::Course::Subject.all
      @age_groups ||= Achiever::Course::AgeGroup.all
    end

    def courses
      @courses ||= begin
        courses = all_courses

        courses.each do |course|
          course_occurrences.each do |course_occurrence|
            if course_occurrence.course_template_no == course.course_template_no
              course.occurrences.push(course_occurrence)
            end
          end
        end
        courses.reject! { |c| c.occurrences.count.zero? } if current_hub.present?

        filter_courses(courses)
      end
    end

    def course_formats
      @course_formats ||= %i[face_to_face online remote]
    end

    def course_locations
      towns = course_occurrences.reduce([]) do |acc, occurrence|
        occurrence.online_cpd ? acc : acc.push(occurrence.address_town)
      end
      towns.reject do |location|
        location.downcase.include?('remote delivered cpd')
      end.uniq.sort.reject(&:empty?)
    end

    def course_tags
      used_subjects = all_courses.reduce([]) { |tags, c| tags + c.subjects }.uniq.sort
      @subjects.select { |_k, v| used_subjects.include?(v.to_s) }
    end

    def certificates
      @certificates ||= Programme.all.each_with_object({}) do |item, hash|
        hash[item.slug.titlecase] = item.slug
      end
    end

    def current_certificate
      return nil unless @filter_params[:certificate].present?

      @current_certificate ||= @filter_params[:certificate]
    end

    def current_topic
      return nil unless @filter_params[:topic].present?

      @current_topic ||= @filter_params[:topic]
    end

    def current_location
      return nil unless @filter_params[:location].present?

      @current_location ||= @filter_params[:location]
    end

    def current_level
      return nil unless @filter_params[:level].present?

      @current_level ||= @filter_params[:level]
    end

    def current_hub
      return nil unless @filter_params[:hub_id].present?

      @current_hub ||= begin
        course_occurrences.map(&:hub_name).compact.first || :no_courses
      end
    end

    def current_format
      return nil unless @filter_params[:course_format].present?

      @current_format ||= @filter_params[:course_format]
    end

    def applied_filters
      filter_strings = []
      filter_strings.push(ERB::Util.html_escape(current_level).to_s) if current_level
      filter_strings.push(ERB::Util.html_escape(current_location).to_s) if current_location
      filter_strings.push(ERB::Util.html_escape(current_topic).to_s) if current_topic
      filter_strings.push(ERB::Util.html_escape(current_certificate).to_s) if current_certificate
      filter_strings.push(ERB::Util.html_escape(current_format).to_s) if current_format
      filter_strings.push(current_hub) if current_hub

      return if filter_strings.empty?

      filter_strings
    end

    private

      def all_courses
        @all_courses ||= Achiever::Course::Template.all
      end

      def course_occurrences
        @course_occurrences ||= begin
          course_occurrences = Achiever::Course::Occurrence.face_to_face + Achiever::Course::Occurrence.online
          filter_course_occurences(course_occurrences)
        end
      end

      def filter_course_occurences(course_occurrences)
        return course_occurrences unless @filter_params[:hub_id].present?

        course_occurrences.select { |co| co.hub_id == @filter_params[:hub_id] }
      end

      def filter_courses(courses)
        courses.select do |c|
          has_certificate = true
          has_level = true
          has_location = true
          has_topic = true
          has_format = true

          has_certificate = c.by_certificate(current_certificate) if current_certificate
          has_level = c.age_groups.any?(current_level_age_group_key) if current_level
          has_location = compare_location(c, current_location) if current_location
          has_topic = c.subjects.any?(current_topic_subject_key) if current_topic
          has_format = current_format.any? { |course_format| by_course_format(c, course_format) } if current_format

          has_certificate && has_level && has_location && has_topic && has_format
        end
      end

      def compare_location(course, location)
        course.occurrences.any? { |oc| oc.address_town == location }
      end

      def by_course_format(course, course_format)
        case course_format
        when 'online'
          course.online_cpd
        when 'remote'
          course.remote_delivered_cpd
        when 'face_to_face'
          !course.online_cpd && !course.remote_delivered_cpd
        end
      end

      def current_topic_subject_key
        @subjects[current_topic].to_s
      end

      def current_level_age_group_key
        @age_groups[current_level].to_s
      end
  end
end
