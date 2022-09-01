require 'rails_helper'

RSpec.describe('components/_footer', type: :view) do
  before do
    render
  end

  it 'has a bursaries link' do
    expect(rendered).to have_link('Funding', href: '/funding')
  end

  it 'has a contact link' do
    expect(rendered).to have_link('Email', href: 'mailto:info@teachcomputing.org')
  end

  it 'has a courses link' do
    expect(rendered).to have_link('Courses', href: '/courses')
  end

  it 'has a resources link' do
    expect(rendered).to have_link('Teaching resources', href: '/curriculum')
  end

  it 'has a news link' do
    expect(rendered).to have_link('News', href: 'https://blog.teachcomputing.org/tag/news/')
  end

  it 'has a privacy link' do
    expect(rendered).to have_link('Privacy', href: '/privacy')
  end

  it 'has a terms and conditions link' do
    expect(rendered).to have_link('Terms and Conditions', href: '/terms-conditions')
  end

  it 'has a press link' do
    expect(rendered).to have_link('Press', href: 'https://blog.teachcomputing.org/tag/press/')
  end

  it 'has an accessibility statement link' do
    expect(rendered).to have_link('Accessibility', href: '/accessibility-statement')
  end

  it 'has an about link' do
    expect(rendered).to have_link('About us', href: '/about')
  end

  it 'has a get involved link' do
    expect(rendered).to have_link('Get involved', href: '/get-involved')
  end

  it 'has a pedagogy link' do
    expect(rendered).to have_link('Pedagogy', href: '/pedagogy')
  end

  it 'has a home teaching link' do
    expect(rendered).to have_link('Home teaching', href: '/home-teaching')
  end

  it 'has a Computing hubs link' do
    expect(rendered).to have_link('Computing hubs', href: '/hubs')
  end

  it 'has a Contributing partners link' do
    expect(rendered).to have_link('Contributing partners', href: '/contributing-partners')
  end

  it 'has a ITE providers link' do
    expect(rendered).to have_link('ITE providers', href: '/support-for-ite-providers')
  end

  it 'has a twitter link' do
    expect(rendered).to have_link('Twitter', href: %r{twitter.com/WeAreComputing})
  end

  it 'has a facebook link' do
    expect(rendered).to have_link('Facebook', href: %r{facebook.com/WeAreComputing})
  end

  it 'has a twitter icon' do
    expect(rendered).to have_xpath('//img[contains(@class, "ncce-link__icon--footer")][contains(@alt, "Twitter logo")]')
  end

  it 'has a facebook icon' do
    expect(rendered).to have_xpath('//img[contains(@class, "ncce-link__icon--footer")][contains(@alt, "Facebook logo")]')
  end
end
