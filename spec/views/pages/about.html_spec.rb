require 'rails_helper'

RSpec.describe('pages/about', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.ncce-about__title', text: 'About')
  end

  it 'links to consortium' do
    expect(rendered).to have_css('.ncce-link', count: 3)
  end

  it 'links to the Offer page' do
    expect(rendered).to have_link('Find out more', href: '/offer', count: 2)
  end

  it 'has a mailto link' do
    expect(rendered).to have_link('Get in touch', href: 'mailto:supporters@teachcomputing.org')
  end
end
