require 'rails_helper'

RSpec.describe('dashboard/show', type: :view) do
  let(:user) { create(:user) }
  let(:activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:user_programme_enrolment) do
    create(:user_programme_enrolment,
           user_id: user.id,
           programme_id: programme.id)
  end

  before do
    [programme, @programmes = Programme.all, activity]
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    create(:achievement, user: user)
    @achievements = user.achievements
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('h1', text: 'Your dashboard')
  end

  it 'has progress section' do
    expect(rendered).to have_css('h2', text: 'Your record of achievement')
  end

  it 'has a link to certification' do
    expect(rendered).to have_link('certification', href: '/certification')
  end

  it 'has an aside' do
    expect(rendered).to have_css('.ncce-aside', count: 1)
  end

  it 'has a link to download the diagnostic tool' do
    expect(rendered).to have_css('a', text: 'diagnostic tool')
  end

  it 'does not show the certificate progress section' do
    expect(rendered).not_to have_css('.govuk-heading-m', text: 'Your certificates')
  end

  context 'when the user has enrolled on a programme' do
    before do
      user_programme_enrolment
      user.reload
      render
    end

    it 'shows the certificate progress section' do
      expect(rendered).to have_css('.govuk-heading-m', text: 'Your certificates')
    end
  end

end
