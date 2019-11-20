Activity.find_or_create_by(slug: 'contribute-to-online-discussion') do |activity|
  activity.title = 'Contribute to online discussion'
  activity.credit = 5
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide a link to your contribution'
  activity.description = 'Engaging in the CAS online discussion forums and webinars.'
end

Activity.find_or_create_by(slug: 'attend-a-cas-community-meeting') do |activity|
  activity.title = 'Attend a CAS Community meeting'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide the date and venue details of the meeting'
  activity.description = 'CAS Community meetings are a great place to meet up with teachers in your area and share best practice. To find your local CAS Community visit- <a href="https://www.computingatschool.org.uk/">www.computingatschool.org.uk</a>.'
end

Activity.find_or_create_by(slug: 'review-a-resource-on-cas') do |activity|
  activity.title = 'Review a resource on CAS'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide a link to your contribution'
  activity.description = 'Head over to the CAS website to review resources you’ve downloaded and used from the CAS community. <a href="https://community.computingatschool.org.uk/resources/2616/single">You can find CAS resources here</a>'
end

Activity.find_or_create_by(slug: 'host-or-attend-a-barefoot-workshop') do |activity|
  activity.title = 'Host or attend a Barefoot Workshop'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'barefoot'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide us with the date and location of the workshop'
  activity.description = 'Barefoot workshops enable you to explore the Barefoot materials, concepts and approaches with a Barefoot volunteer. You can request a free workshop over on the <a href="https://www.barefootcomputing.org/">Barefoot computing website</a>'
end

Activity.find_or_create_by(slug: 'lead-a-cas-community-of-practice') do |activity|
  activity.title = 'Lead a CAS Community of Practice'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = "Please provide us with the name and postcode of the CAS community you're leading"
  activity.description = 'Support the CAS Community further by registering as a CAS Community Leader through the CAS website. You’ll need to commit to running 3 meetings per year to support your local community.'
end

Activity.find_or_create_by(slug: 'run-an-after-school-code-club') do |activity|
  activity.title = 'Run an after-school Code Club'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'code-club'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide us with the name and postcode of your Code Club'
  activity.description = 'Code Club supports schools and teachers nationwide to run free after-school coding clubs for 9- to 13-year-olds. Code Clubs are simple to run and help students develop a range of skills, including problem-solving and digital literacy. The Code Club team provides free, hands-on coding activities that spark curiosity and inspire creative thinking: <a href="https://codeclub.org/en/start-a-code-club" class="ncce-link">Start a Code Club in your school today</a>'
end

Activity.find_or_create_by(slug: 'lead-a-session-at-a-regional-or-national-conference') do |activity|
  activity.title = 'Lead a session at a regional or national conference'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'community'
  activity.provider = 'cas'
  activity.self_certifiable = true
  activity.self_verification_info = 'Please provide us with a link conference programme'
end
