require 'rails_helper'

RSpec.describe Admin::ActivitiesController do
  let(:activities) { create_list(:activity, 10) }
  let(:token_headers) { { 'HTTP_AUTHORIZATION': 'Bearer secret', 'HTTP_CONTENT_TYPE': 'application/json' } }

  context 'token is not passed' do
    describe 'GET #show' do
      before do
        activities
        get "/admin/activities/", { headers: nil }
      end

      it 'returns 401 status' do
        expect(response.status).to eq 401
      end
    end
  end

  context 'when the correct token is passed' do
    describe 'GET #show' do
      before do
        activities
        get "/admin/activities/", { headers: token_headers }
      end

      it 'returns 201 status' do
        expect(response.status).to eq 200
      end

      it 'returns the 10 activities' do
        expect(JSON.parse(response.body).count).to eq 10
      end
    end
  end
end
