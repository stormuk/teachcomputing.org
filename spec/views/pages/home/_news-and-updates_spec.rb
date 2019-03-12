require 'rails_helper'

RSpec.describe('pages/home/_news-and-updates', type: :view) do
  before do
    render
  end

  it('renders the correct number of cards') do
    expect(rendered).to(have_css('.ncce-news-and-updates__panel', count: 2))
  end
end
