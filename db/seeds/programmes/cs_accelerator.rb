cs_accelerator = Programmes::CSAccelerator.find_or_create_by(slug: 'cs-accelerator') do |programme|
  programme.title = 'Teach GCSE computer science'
  programme.slug = 'cs-accelerator'
  programme.description = 'If you’re a secondary school teacher without a post A level qualification in computer science or a related subject then the Computer Science Accelerator Programme is specifically designed to help you.'
  programme.enrollable = true
end

puts "Created Programme: #{cs_accelerator.title} (#{cs_accelerator})"

activity = Activity.find_by(slug: 'cs-accelerator-assessment')

assessment = Assessment.find_or_create_by(programme_id: cs_accelerator.id) do |assessment|
  assessment.programme_id = cs_accelerator.id
  assessment.activity_id = activity.id
  assessment.link = 'https://www.classmarker.com/online-test/start/?quiz=7jq5caf0e6ab8da3'
  assessment.class_marker_test_id = '1071279'
end

puts "Created assessment: #{assessment.activity.title} (#{assessment})"

programme_complete_counter = ProgrammeCompleteCounter.find_or_create_by(programme_id: cs_accelerator.id) do |programme_complete_counter|
  programme_complete_counter.programme_id = cs_accelerator.id
  programme_complete_counter.counter = 0
end

puts "Created programme_complete_counter: #{programme_complete_counter}"

slugs = %w[
  registered-with-the-national-centre
  cs-accelerator-diagnostic-tool
  algorithms-in-gcse-computer-science
  data-and-computer-systems-in-gcse-computer-science
  networks-and-cyber-security-in-gcse-computer-science
  python-programming-essentials-for-gcse-computer-science
  teaching-physical-computing-with-raspberry-pi-and-python
  how-computers-work-demystifying-computation
  programming-101-an-introduction-to-python-for-educators
  programming-102-think-like-a-computer-scientist
  programming-103-saving-and-structuring-data
  representing-data-with-images-and-sound-bringing-data-to-life
  object-oriented-programming-in-python-create-your-own-adventure-game
  an-introduction-to-computer-networking-for-teachers
  understanding-maths-and-logic-in-computer-science
  understanding-computer-systems
  cs-accelerator-assessment
  introduction-to-cybersecurity-for-teachers
  ncce-coaching-and-mentoring
  impact-of-technology-how-to-lead-classroom-discussions
  design-and-prototype-embedded-computer-systems
  programming-103-saving-and-structuring-data
  introduction-to-encryption-and-cryptography
  introduction-to-web-development
  networking-with-python-socket-programming-for-communication
  pre-january-2019-csa-face-to-face-cpd
  robotics-with-raspberry-pi-build-and-program-your-first-robot-buggy
  programming-with-guis
  gcse-computer-science-developing-outstanding-teaching
  ks4-computing-for-all
  introduction-to-gcse-computer-science
  search-and-sort-algorithms
  representing-algorithms-using-flowcharts-and-pseudocode
  computer-systems-input-output-and-storage
  computer-processors
  fundamentals-of-computer-networks
  the-internet-and-cyber-security
  python-programming-constructs-sequencing-selection-iteration
  python-programming-working-with-data
  an-introduction-to-algorithms-programming-and-data-in-gcse-computer-science
  an-introduction-to-computer-systems-networking-and-security-in-gcse-computer-science
  introduction-to-databases-and-sql
  python-programming-constructs-sequencing-selection-iteration
  fundamentals-of-computer-networks
  representing-algorithms-using-flowcharts-and-pseudocode
]

slugs.each do |slug|
  activity = Activity.find_by(slug: slug)
  unless activity.programmes.include?(cs_accelerator)
    puts "Adding: #{activity.title} to #{cs_accelerator.slug}"
    activity.programmes << cs_accelerator
  end
end
