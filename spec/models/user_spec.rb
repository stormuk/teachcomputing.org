require 'rails_helper'

RSpec.describe User, type: :model do
  let(:stem_credentials) do
    OmniAuth::AuthHash.new(expires: true,
                           expires_at: Time.zone.now.to_i,
                           refresh_token: '123-refresh-token',
                           token: '123-token')
  end
  let(:stem_info) do
    OmniAuth::AuthHash::InfoHash.new(achiever_contact_no: '123456',
                                     email: 'user@example.com',
                                     first_name: 'Jane',
                                     last_name: 'Doe')
  end
  let(:uid) { '987654321abcDEF' }
  let(:user) do
    User.from_auth(uid,
                   stem_credentials,
                   stem_info)
  end

  describe 'validations' do
    before do
      user
    end

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:stem_achiever_contact_no) }
    it { is_expected.to validate_presence_of(:stem_credentials_access_token) }
    it { is_expected.to validate_presence_of(:stem_credentials_refresh_token) }
    it { is_expected.to validate_presence_of(:stem_credentials_expires_at) }
    it { is_expected.to validate_presence_of(:stem_user_id) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:stem_user_id) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_uniqueness_of(:teacher_reference_number) }
  end

  describe 'encryption' do
    it 'encrypts stem_credentials_access_token' do
      expect(user.stem_credentials_access_token).not_to be_nil
      expect(user.encrypted_stem_credentials_access_token).not_to eq user.stem_credentials_access_token
    end

    it 'encrypts stem_credentials_refresh_token' do
      expect(user.stem_credentials_refresh_token).not_to be_nil
      expect(user.encrypted_stem_credentials_refresh_token).not_to eq user.stem_credentials_refresh_token
    end
  end

  describe 'associations' do
    it 'has_many achievements' do
      expect(user).to have_many(:achievements)
    end

    it 'has_many activities through achievements' do
      expect(user).to have_many(:activities).through(:achievements)
    end

    it 'has_many programmes through achievements' do
      expect(user).to have_many(:programmes).through(:user_programme_enrolments)
    end

    it 'has_many resource_users' do
      expect(user).to have_many(:resource_users)
    end

    it 'has_many questionnaire_responses' do
      expect(user).to have_many(:questionnaire_response)
    end
  end

  describe '#from_auth' do
    it 'has the correct id' do
      expect(user.stem_user_id).to eq uid
    end

    it 'has the correct first name' do
      expect(user.first_name).to eq 'Jane'
    end

    it 'has the correct last name' do
      expect(user.last_name).to eq 'Doe'
    end

    it 'has the correct email' do
      expect(user.email).to eq 'user@example.com'
    end

    it 'has the correct achiver contact number' do
      expect(user.stem_achiever_contact_no).to eq '123456'
    end

    it 'has the correct token' do
      expect(user.stem_credentials_access_token).to eq '123-token'
    end

    it 'has the correct refresh token' do
      expect(user.stem_credentials_refresh_token).to eq '123-refresh-token'
    end

    it 'has the correct expires at' do
      expect(user.stem_credentials_expires_at).to be_today
    end

    it 'has the last sign in date set' do
      expect(user.last_sign_in_at).to be_today
    end
  end

  describe '#enrolments' do
    it 'returns UserProgrammeEnrolments for the given user' do
      enrolment = create(:user_programme_enrolment, user_id: user.id)
      expect(user.enrolments).to include enrolment
    end
  end
end
