require 'rails_helper'

RSpec.describe Credly::IssueBadgeJob, type: :job do
  let(:user) { create(:user, email: 'web@raspberrypi.org') }
  let(:programme) { create(:cs_accelerator) }
  let(:badge) { create(:badge, :active, programme_id: programme.id, credly_badge_template_id: '00cd7d3b-baca-442b-bce5-f20666ed591b') }

  describe '#perform' do
    before do
      allow(Credly::Badge).to receive(:issue).and_return(true)
    end

    context 'when the feature flag is enabled' do
      before do
        stub_feature_flags({ badges_enabled: true })
      end

      after do
        unstub_feature_flags
      end

      context 'when the user does not already have the badge' do
        before do
          badge
          stub_issued_badges_empty(user.id)
        end

        it 'calls Credly::Badge.issue' do
          described_class.perform_now(user.id, programme.id)
          expect(Credly::Badge).to have_received(:issue)
        end
      end
    end

    context 'when the feature flag is not enabled' do
      it 'does not call Credly::Badge.issue' do
        described_class.perform_now(user.id, programme.id)
        expect(Credly::Badge).not_to have_received(:issue)
      end
    end
  end
end
