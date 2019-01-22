require 'rails_helper'

RSpec.describe('pages/offer', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-l', text: 'What We Offer')
  end
end
