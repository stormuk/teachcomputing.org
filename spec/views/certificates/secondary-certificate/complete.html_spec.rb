require 'rails_helper'

RSpec.describe('certificates/secondary_certificate/complete', type: :view) do
  let(:user) { create(:user) }
  let(:secondary_certificate) { create(:secondary_certificate) }

  before do
    @programme = secondary_certificate
    assign(:complete_achievements, user.achievements.for_programme(secondary_certificate).sort_complete_first)
    render
  end

  it 'has the programme title' do
    expect(rendered).to have_css('.hero__heading', text: @programme.title)
  end

  it 'has the download button' do
    expect(rendered).to have_link('Download your certificate', href: '/certificate/secondary-certificate/view-certificate')
  end

  it 'has the Browse all courses button' do
    expect(rendered).to have_link('Browse all courses', href: '/courses')
  end

  it 'has Find out more about CAS button' do
    expect(rendered).to have_link('Find out more', href: 'https://community.computingatschool.org.uk/events')
  end

  it 'has the journey section' do
    expect(rendered).to have_css('.ncce-programmes-activity__title', text: 'Your learning journey')
  end

  it 'has the Twitter section' do
    expect(rendered).to have_css('.ncce-aside__title', text: 'Share your success')
  end
end
