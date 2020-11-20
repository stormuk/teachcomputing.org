require 'rails_helper'

RSpec.describe('certificates/secondary_certificate/pending', type: :view) do
  let(:user) { create(:user) }
  let(:secondary_certificate) { create(:secondary_certificate) }

  before do
    @programme = secondary_certificate
    assign(:complete_achievements, user.achievements.for_programme(secondary_certificate).sort_complete_first)
    render
  end

  it 'has the programme title' do
    expect(rendered).to have_css('.govuk-body-l', text: 'Well done! You have completed the programme')
  end

  it 'has the roa' do
    expect(rendered).to have_css('.ncce-activity-list', count: 1)
  end
end
