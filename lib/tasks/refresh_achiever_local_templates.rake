namespace :achiever do
  task refresh_local_templates: :environment do
    raise Error, 'Missing ACHIEVER_LOCAL_TEMPLATE_PATH' unless ENV['ACHIEVER_LOCAL_TEMPLATE_PATH'].present?

    def friendly_name(path)
      matches = /Get\?cmd=(.*)/.match(path)
      matches[1]&.to_sym&.downcase
    end

    def query_strings(query)
      query.map { |k, v| "#{k}=#{v}" }.join('&')
    end

    def query_and_write_file(details)
      name = friendly_name(details[:path])
      puts "Retrieving data from: #{details[:path]}"
      response = Achiever::Connection.api.get("#{details[:path]}&#{query_strings(details[:params])}")
      puts "Writing data to: #{name}.json"
      file = File.new("#{ENV['ACHIEVER_LOCAL_TEMPLATE_PATH']}/#{name}.json", 'wb+')
      file.write(response.body)
    end

    option_sets = [
      { path: Achiever::Course::AgeGroup::RESOURCE_PATH, params: Achiever::Course::AgeGroup::QUERY_STRINGS },
      { path: Achiever::Course::Attendance::RESOURCE_PATH, params: Achiever::Course::Attendance::QUERY_STRINGS },
      { path: Achiever::Course::DurationUnit::RESOURCE_PATH, params: {} },
      { path: Achiever::Course::Subject::RESOURCE_PATH, params: {} }
    ]

    option_sets.each do |option_set|
      query_and_write_file option_set
    end

    resources = [
      { path: Achiever::Course::Template::RESOURCE_PATH, params: Achiever::Course::Template::QUERY_STRINGS },
      { path: Achiever::Course::Occurrence::FACE_TO_FACE_RESOURCE_PATH, params: Achiever::Course::Occurrence::QUERY_STRINGS },
      { path: Achiever::Course::Occurrence::ONLINE_RESOURCE_PATH, params: Achiever::Course::Occurrence::QUERY_STRINGS },
      { path: Achiever::Course::OccurrenceDetails::RESOURCE_PATH, params: {
        Page: '1', RecordCount: '1000', ProgrammeName: 'ncce', ID: '5e91e211-cd0a-ea11-a811-000d3a86d545'
      } }, # contact_no here is for the staging web@raspberrypi.org account
      { path: Achiever::Course::Delegate::RESOURCE_PATH, params: {
        Page: '1', RecordCount: '1000', ProgrammeName: 'ncce', CONTACTNO: '89085e3f-d60e-eb11-a813-000d3a86f6ce'
      } } # this is a random course
    ]

    resources.each do |resource|
      query_and_write_file resource
    end
  end
end
