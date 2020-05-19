cs_accelerator = Programme.cs_accelerator
primary_certificate = Programme.primary_certificate
# secondary_certificate = Programme.secondary_certificate

a = Activity.find_or_create_by(slug: 'registered-with-the-national-centre') do |activity|
  activity.title = 'Created your account with the National Centre for Computing Education'
  activity.credit = 5
  activity.slug = 'registered-with-the-national-centre'
  activity.category = 'action'
  activity.self_certifiable = false
  activity.provider = 'system'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)
a.programmes << primary_certificate unless a.programmes.include?(primary_certificate)
# a.programmes << secondary_certificate unless a.programmes.include?(secondary_certificate)

a = Activity.find_or_create_by(slug: 'ncce-coaching-and-mentoring') do |activity|
  activity.title = 'NCCE - Coaching and Mentoring'
  activity.credit = 0
  activity.slug = 'ncce-coaching-and-mentoring'
  activity.stem_course_template_no = 'eb7c08ea-212a-4d27-8bde-a629f36192f6'
  activity.category = 'action'
  activity.provider = 'stem-learning'
end

a.programmes << cs_accelerator unless a.programmes.include?(cs_accelerator)
