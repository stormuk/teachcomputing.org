require 'rails_helper'

RSpec.describe('dashboard/programmes/_cs-accelerator', type: :view) do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :diagnostic_tool) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
           user_id: user.id,
           programme_id: programme.id)
  end
  let(:exam_activity) { create(:activity, :cs_accelerator_exam )}
  let(:programme_activity) { create(:programme_activity, programme_id: programme.id, activity_id: exam_activity.id) }
  let(:passed_exam) { create(:completed_achievement, user_id: user.id, activity_id: exam_activity.id) }

  before do
    [programme, @programmes = Programme.all, activity]
    programme_activity
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    create(:achievement, user: user)
    @achievements = user.achievements
    render :template => 'dashboard/programmes/_cs-accelerator', :locals => { programme: programme }
  end

  context 'when the user hasn\'t enrolled onto the CS Accelerator programme' do
    before do
      @certification_enabled = true
      render :template => 'dashboard/programmes/_cs-accelerator', :locals => { programme: programme }
    end

    it 'shows the certificate progress section' do
      expect(rendered).to have_css('h1', text: 'on the National Centre for Computing Education certificate in')
    end

    it 'shows the certificate name' do
      expect(rendered).to have_css('h2', text: programme.title)
    end

    it 'shows the enrollment button' do
      expect(rendered).to have_link('Find out more & enrol', href: cs_accelerator_path)
    end
  end

  context 'when the user has enrolled onto the CS Accelerator programme' do
    before do
      @certification_enabled = true
      user_programme_enrolment
      render :template => 'dashboard/programmes/_cs-accelerator', :locals => { programme: programme }
    end

    it 'shows the certificate progress section' do
      expect(rendered).to have_css('.underlined__title', text: 'Your certificate')
    end

    it 'shows the certificate link' do
      expect(rendered).to have_link(programme.title, href: programme_path(slug: programme.slug))
    end

    it 'shows the progress bar' do
      expect(rendered).to have_css('.certification-progress__fudge-bar', count: 1)
    end
  end

  context 'when the user has completed the CS Accelerator programme' do
    before do
      @certification_enabled = true
      user_programme_enrolment
      passed_exam
      render :template => 'dashboard/programmes/_cs-accelerator', :locals => { programme: programme }
    end

    it 'shows the certificate complete section' do
      expect(rendered).to have_css('.underlined__title', text: 'Your certificate')
    end

    it 'shows the certificate link' do
      expect(rendered).to have_link(programme.title, href: programme_complete_path(slug: programme.slug))
    end

    it 'shows the completed text' do
      expect(rendered).to have_css('.pink-text', text: 'Completed!')
    end

    it 'shows the image' do
        expect(rendered).to have_css('.certification-hero__image--dashboard', count: 1)
      end
  end
end
