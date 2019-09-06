class Achiever::Course::AgeGroup
  RESOURCE_PATH = 'Get?cmd=OptionsetAgeGroups'.freeze
  QUERY_STRINGS = { 'Page': '1',
                    'RecordCount': '1000' }.freeze

  def self.all
    age_groups = Achiever::Request.option_sets(RESOURCE_PATH, QUERY_STRINGS)
    parsed_response = JSON.parse(age_groups)
    parsed_response.reduce({}, :merge)
                   .select { |k| k.starts_with?('Key') }
  end
end
