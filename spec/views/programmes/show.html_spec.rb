require 'rails_helper'

RSpec.describe('programmes/show', type: :view) do
  let(:user) { create(:user) }
  let(:programme) { create(:programme, slug: 'cs-accelerator') }
  let(:assessment) { create(:assessment, programme_id: programme.id) }

  before do
    assessment
    @programme = programme
    allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    render
  end

end
