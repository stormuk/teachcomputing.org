require 'rails_helper'

RSpec.describe('curriculum/key_stages/show', type: :view) do
  let(:unit_json) { File.new('spec/support/curriculum/views/key_stage.json').read }
  let(:user) { create(:user) }
  let(:setup_view) do
    json = JSON.parse(unit_json, object_class: OpenStruct).data
    assign(:key_stage, json.key_stage)
  end

  context 'when no user is signed in' do
    before do
      setup_view
      render
    end

    it 'shows the breadcrumb partial' do
      expect(rendered).to have_link('Curriculum', href: '/curriculum')
      expect(rendered).to have_css('.curriculum__breadcrumb', text: 'KS1')
    end

    it 'has a title' do
      expect(rendered).to have_css('.hero__heading', text: 'Key stage 1 resources')
    end

    it 'links to feedback form' do
      expect(rendered).to have_link('Provide your feedback', href: 'https://forms.gle/qT2XqoCecYjLLohC6')
    end

    it 'does not show the rating partial' do
      expect(rendered).not_to have_css('.curriculum__rating')
    end

    context 'when it shows the years partial' do
      it 'shows the titles' do
        expect(rendered).to have_text('Year 1')
        expect(rendered).to have_text('Year 2')
      end

      it 'shows the links' do
        expect(rendered).to have_link('Unit 1', href: '/curriculum/key-stage-1/unit-1')
        expect(rendered).to have_link('Unit 2', href: '/curriculum/key-stage-1/unit-2')
      end
    end
  end

  context 'when a user is signed in' do
    before do
      setup_view
      allow(view).to receive(:current_user).and_return(user)
      render
    end

    it 'still does not show the rating partial' do
      expect(rendered).not_to have_css('.curriculum__rating')
    end
  end
end
