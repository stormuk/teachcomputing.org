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
  let(:uid) { '987654321' }
  let(:user) do
    User.from_auth(uid,
                   stem_credentials,
                   stem_info)
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:stem_achiever_contact_no) }
    it { is_expected.to validate_presence_of(:stem_credentials_access_token) }
    it { is_expected.to validate_presence_of(:stem_credentials_refresh_token) }
    it { is_expected.to validate_presence_of(:stem_credentials_expires_at) }
    it { is_expected.to validate_presence_of(:stem_user_id) }
    it { is_expected.to validate_uniqueness_of(:stem_user_id) }
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
      expect(user.stem_credentials_expires_at.today?).to be_truthy
    end

    it 'has the last sign in date set' do
      expect(user.last_sign_in_at.today?).to be_truthy
    end
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
end
