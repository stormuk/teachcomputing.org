require 'rails_helper'

RSpec.describe Curriculum::KeyStagesController do
  let(:key_stage_json_response) { File.new('spec/support/curriculum/responses/key_stage.json').read }

  describe 'GET #show' do
    context 'when curriculum is enabled' do
      it 'renders the show template' do
        stub_a_valid_request(key_stage_json_response)
        get curriculum_key_stage_units_path(key_stage_slug: 'key-stage-1')
        expect(response).to render_template(:show)
      end
    end
  end
end
