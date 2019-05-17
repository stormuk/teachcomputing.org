require 'rails_helper'

RSpec.describe('programmes/_action_activity', type: :view) do
  it 'shows the registered activity' do
    render
    expect(rendered).to have_css('.ncce-activity-list__item', text: 'Signed up to the National Centre for Computing Education')
  end

  context 'when user has not downloaded the diagnostic' do
    before do
      render
    end

    it 'diagnostic achievement is  marked as incomplete' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 1)
    end

    it 'has a download diagnostic button' do
      expect(rendered).to have_link('Do the diagnostic', count: 1)
    end
  end

  context 'when user has downloaded the diagnostic' do
    before do
      @downloaded_diagnostic = true
      render
    end

    it 'diagnostic achievement is marked as complete' do
      expect(rendered).to have_css('.ncce-activity-list__item--incomplete', count: 0)
    end

    it 'has a completed text' do
      expect(rendered).to have_css('.ncce-activity-list__item-text', text: /Completed the diagnostic test/)
    end
  end

end
