require 'rails_helper'

RSpec.describe('pages/about', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.ncce-about__title', text: 'About')
  end

  it 'links to consortium' do
    expect(rendered).to have_css('.govuk-link', count: 3)
  end

  it 'links to the About page' do
    expect(rendered).to have_link('Find out more', href: '/about')
  end
end
