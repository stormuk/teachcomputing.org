require 'rails_helper'

RSpec.describe ResourcesController do
  let(:redirect_url) { URI.encode_www_form_component('https://ncce.io/Year1') }
  let(:user) { create(:user) }


  describe '#show' do
    before do
      allow_any_instance_of(AuthenticationHelper)
        .to receive(:current_user).and_return(user)
    end

    it 'renders the index template' do
      get resources_redirect_path(redirect_url: redirect_url, year: 1)
      expect(response).to redirect_to('https://ncce.io/Year1')
    end

    it 'queues CsAcceleratorEnrolmentTransitionJob job' do
      expect do
        get resources_redirect_path(redirect_url: redirect_url, year: 1)
      end.to have_enqueued_job(ScheduleUserResourcesFeedbackJob)
    end
  end
end
