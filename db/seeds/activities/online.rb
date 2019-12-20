Activity.find_or_create_by(slug: 'teaching-physical-computing-with-raspberry-pi-and-python') do |activity|
  activity.title = 'Teaching Physical Computing with Raspberry Pi and Python'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = 'ecf78d20-2966-4798-af5f-0f869c1818e2'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'how-computers-work-demystifying-computation') do |activity|
  activity.title = 'How Computers Work: Demystifying Computation'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = 'c88099c0-8b44-42a5-aad3-0dd011fe3490'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'programming-101-an-introduction-to-python-for-educators') do |activity|
  activity.title = 'Programming 101: An Introduction to Python for Educators'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = 'c9fb59cc-6393-4a29-8136-7020128ca879'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'programming-102-think-like-a-computer-scientist') do |activity|
  activity.title = 'Programming 102: Think like a Computer Scientist'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = 'd9fe6126-298f-48ed-8be3-b82e1c473566'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'representing-data-with-images-and-sound-bringing-data-to-life') do |activity|
  activity.title = 'Representing Data with Images and Sound: Bringing Data to Life'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = 'e290318f-ba23-4c95-8f18-584946233af9'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'object-oriented-programming-in-python-create-your-own-adventure-game') do |activity|
  activity.title = 'Object-oriented Programming in Python: Create Your Own Adventure Game'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = '2e1e3f69-b200-4fc7-a6bd-dff682bdd228'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'an-introduction-to-computer-networking-for-teachers') do |activity|
  activity.title = 'An Introduction to Computer Networking for Teachers'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = '6c5bddfb-7dd4-467b-9554-34f3aedc233f'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'understanding-maths-and-logic-in-computer-science') do |activity|
  activity.title = 'Understanding Maths and Logic in Computer Science'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = 'ffc6793d-5643-40c8-893a-0164844ca62f'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'understanding-computer-systems') do |activity|
  activity.title = 'Understanding Computer Systems'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = '04953102-a4cf-485d-a34e-0c64621033be'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'teaching-programming-in-primary-schools') do |activity|
  activity.title = 'Teaching Programming in Primary Schools'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = '4ec560a3-6435-46bc-90b7-75cfdcf7e72d'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'scratch-to-python-moving-from-block-to-text-based-programming') do |activity|
  activity.title = 'Scratch to Python: Moving from Block- to Text-based Programming'
  activity.credit = 10
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = '3ce9a624-6cc7-4d23-8f5f-95162e360178'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'impact-of-technology-how-to-lead-classroom-discussions') do |activity|
  activity.title = 'Impact of Technology: How To Lead Classroom Discussions'
  activity.credit = 20
  activity.slug = activity.title.parameterize
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = 'e4115d3c-53d0-4538-94c2-e2a9ba366178'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'introduction-to-cybersecurity-for-teachers') do |activity|
  activity.title = 'Introduction to Cybersecurity for Teachers'
  activity.credit = 20
  activity.slug = 'introduction-to-cybersecurity-for-teachers'
  activity.category = 'online'
  activity.self_certifiable = true
  activity.future_learn_course_id = '030261f8-1e96-4a70-a329-e3eb8b868915'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'programming-with-guis') do |activity|
  activity.title = 'Programming with GUIs'
  activity.credit = 20
  activity.slug = 'programming-with-guis'
  activity.category = 'online'
  activity.self_certifiable = false
  activity.future_learn_course_id = '645ec51f-0b46-4102-a364-90647057f4f2'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'creating-an-inclusive-classroom-approaches-to-supporting-learners-with-send-in-computing') do |activity|
  activity.title = 'Creating an Inclusive Classroom: Approaches to Supporting Learners with SEND in Computing'
  activity.credit = 20
  activity.slug = 'creating-an-inclusive-classroom-approaches-to-supporting-learners-with-send-in-computing'
  activity.category = 'online'
  activity.self_certifiable = false
  activity.future_learn_course_id = 'b19646a7-d78b-4a92-ad36-d4b3a11a3df1'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'design-and-prototype-embedded-computer-systems') do |activity|
  activity.title = 'Design and Prototype Embedded Computer Systems'
  activity.credit = 20
  activity.slug = 'design-and-prototype-embedded-computer-systems'
  activity.category = 'online'
  activity.self_certifiable = false
  activity.future_learn_course_id = '83c939cf-8aa7-43d9-ad06-acaa3b859d91'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'programming-103-saving-and-structuring-data') do |activity|
  activity.title = 'Programming 103: Saving and Structuring Data'
  activity.credit = 20
  activity.slug = 'programming-103-saving-and-structuring-data'
  activity.category = 'online'
  activity.self_certifiable = false
  activity.future_learn_course_id = '66ceead6-5641-485c-9d10-40a35b8e465e'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'programming-pedagogy-in-primary-schools-developing-computing-teaching') do |activity|
  activity.title = 'Programming Pedagogy in Primary Schools: Developing Computing Teaching'
  activity.credit = 20
  activity.slug = 'programming-pedagogy-in-primary-schools-developing-computing-teaching'
  activity.category = 'online'
  activity.self_certifiable = false
  activity.future_learn_course_id = '26e9cd23-2d71-4964-9af3-751aa3fdc8e5'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'introduction-to-encryption-and-cryptography') do |activity|
  activity.title = 'Introduction to Encryption and Cryptography'
  activity.credit = 20
  activity.slug = 'introduction-to-encryption-and-cryptography'
  activity.category = 'online'
  activity.self_certifiable = false
  activity.future_learn_course_id = 'a1520b0c-8c99-49e5-8c65-f025f3431ab0'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'programming-pedagogy-in-secondary-schools-inspiring-computing-teaching') do |activity|
  activity.title = 'Programming Pedagogy in Secondary Schools: Inspiring Computing Teaching'
  activity.credit = 20
  activity.slug = 'programming-pedagogy-in-secondary-schools-inspiring-computing-teaching'
  activity.category = 'online'
  activity.self_certifiable = false
  activity.future_learn_course_id = '6cd40c14-adbf-4da7-af81-849d0f74a2fe'
  activity.provider = 'future-learn'
end

Activity.find_or_create_by(slug: 'introduction-to-web-development') do |activity|
  activity.title = 'Introduction to Web Development'
  activity.credit = 20
  activity.slug = 'introduction-to-web-development'
  activity.category = 'online'
  activity.self_certifiable = false
  activity.future_learn_course_id = '3574403e-a63f-4230-9f4b-3f5b6cd4ddb7'
  activity.provider = 'future-learn'
end
