require 'rails_helper'

RSpec.describe('components/_footer', type: :view) do
  before do
    render
  end

  it 'has a link to the home page ' do
    expect(rendered).to have_link('National Centre forComputing Education', href: '/')
  end

  it 'has an about link' do
    expect(rendered).to have_link('About', href: '/about')
  end

  it 'has a contact link' do
    expect(rendered).to have_link('Contact', href: 'mailto:info@teachcomputing.org')
  end

  it 'has a privacy link' do
    expect(rendered).to have_link('Privacy', href: '/privacy')
  end

  it 'has a press link' do
    expect(rendered).to have_link('Press', href: '/press')
  end

  it 'has a twitter link' do
    expect(rendered).to have_link('Twitter', href: /twitter.com\/WeAreComputing/)
  end

  it 'has a facebook link' do
    expect(rendered).to have_link('Facebook', href: /facebook.com\/WeAreComputing/)
  end

  it 'has a twitter icon' do
    expect(rendered).to have_xpath('//img[contains(@class, "ncce-link__icon--footer")][contains(@alt, "Twitter logo")]')
  end

  it 'has a facebook icon' do
    expect(rendered).to have_xpath('//img[contains(@class, "ncce-link__icon--footer")][contains(@alt, "Facebook logo")]')
  end

end
