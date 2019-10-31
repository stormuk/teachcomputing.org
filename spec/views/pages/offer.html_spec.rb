require 'rails_helper'

RSpec.describe('pages/offer', type: :view) do
  before do
    render
  end

  it 'has a title' do
    expect(rendered).to have_css('.govuk-heading-xl', text: 'What We Offer')
  end

  it 'has login links' do
    expect(rendered).to have_link('Browse available courses', href: '/courses', count: 4)
  end

  it 'has an accelerator link' do
    expect(rendered).to have_link('Find out more', href: '/accelerator')
  end

  it 'has a bursary link' do
    expect(rendered).to have_link('Find out more', href: '/bursary')
  end

  it 'has a news link' do
    expect(rendered).to have_link('recent article', href: 'https://blog.teachcomputing.org/a-level')
  end

  it 'has a find community link' do
    expect(rendered).to have_link('Find your local community', href: /computingatschool\.org\.uk/)
  end

  it 'has a resource link' do
    expect(rendered).to have_link('Access resources', href: '/resources')
  end

  it 'has a certification link' do
    expect(rendered).to have_link('Find out more about certification', href: '/certification')
  end

  it 'has links to anchors' do
    expect(rendered).to have_xpath('//a[starts-with(@href, "#")]', count: 2)
  end

  it 'has anchors' do
    expect(rendered).to have_xpath('//a[@id]', count: 4)
  end
end
