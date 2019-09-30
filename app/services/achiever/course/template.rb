class Achiever::Course::Template
  attr_accessor :activity_code,
                :age_groups,
                :booking_url,
                :course_template_no,
                :meta_description,
                :occurrences,
                :online_cpd,
                :subjects,
                :summary,
                :title,
                :workstream

  RESOURCE_PATH = 'Get?cmd=CourseTemplatesListingByProgramme'.freeze
  QUERY_STRINGS = { 'Page': '1',
                    'RecordCount': '1000',
                    'HideFromweb': '0',
                    'ProgrammeName': 'ncce' }.freeze

  def initialize(template)
    @activity_code = template.send('Template.ActivityCode')
    @age_groups = template.send('Template.AgeGroups').split(';')
    @booking_url = template.send('Template.BookingURL')
    @course_template_no = template.send('Template.COURSETEMPLATENO')
    @meta_description = template.send('Template.MetaDescription')
    @online_cpd = ActiveRecord::Type::Boolean.new.deserialize(template.send('Template.OnlineCPD').downcase)
    @occurrences = []
    @subjects = template.send('Template.AdditionalSubjects').split(';')
    @summary = template.send('Template.Summary')
    @title = template.send('Template.TemplateTitle')
    @workstream = template.send('Template.Workstream')
  end

  def self.all
    templates = Achiever::Request.resource(RESOURCE_PATH, QUERY_STRINGS)
    templates.map { |course| Achiever::Course::Template.new(course) }
  end

  def by_certificate(certificate)
    return @workstream == 'CS Accelerator' if certificate == 'cs-accelerator'
    key_stages = Achiever::Course::AgeGroup.send(certificate.underscore)
    @workstream == 'National Centre - Core' && key_stages.any? { |key_stage| @age_groups.any?(key_stage.to_s) }
  end
end
