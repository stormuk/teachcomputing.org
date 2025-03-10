require 'rails_helper'

RSpec.describe Activity, type: :model do
  let(:activity) { create(:activity) }
  let(:online_activity) { create(:activity, :future_learn) }
  let(:face_to_face_activity) { create(:activity, :face_to_face) }
  let(:online_courses) { create_list(:activity, 3, :future_learn) }
  let(:face_to_face_courses) { create_list(:activity, 3, :stem_learning) }
  let(:community_activity) { create(:activity, :community) }
  let(:system_activity) { create_list(:activity, 3, :system) }
  let(:user) { create(:user) }
  let(:user_achievement) { create(:achievement, user_id: user.id, activity_id: online_activity.id) }
  let(:diagnostic_tool_activity) { create(:activity, :cs_accelerator_diagnostic_tool) }
  let(:removable_activity) { create(:activity, :user_removable) }

  describe 'associations' do
    it 'has_one assessment' do
      expect(activity).to have_one(:assessment)
    end

    it 'has_many pathway_activities' do
      expect(activity).to have_many(:pathway_activities)
    end

    it 'has_many achievements' do
      expect(activity).to have_many(:achievements)
    end

    it 'has_many users' do
      expect(activity).to have_many(:users).through(:achievements)
    end

    it 'has_many programmes' do
      expect(activity).to have_many(:programmes).through(:programme_activities)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_inclusion_of(:category).in_array(%w[action online face-to-face]) }
    it { is_expected.to validate_uniqueness_of(:future_learn_course_uuid) }
    it { is_expected.to validate_uniqueness_of(:stem_activity_code) }
    it { is_expected.to validate_uniqueness_of(:stem_course_template_no) }
  end

  describe 'scopes' do
    describe 'available_for' do
      before do
        [online_activity, online_courses, user, user_achievement]
      end

      it 'lists available online activities for a given user' do
        expect(described_class.available_for(user)).to match_array(online_courses)
      end

      it 'does not include activities if a user already has an existing achievement' do
        expect(described_class.available_for(user)).not_to include(online_activity)
      end
    end

    describe 'online' do
      before do
        [online_courses, face_to_face_courses]
      end

      it 'includes only online activities' do
        expect(described_class.online).to match_array(online_courses)
      end

      it 'does not include actions' do
        expect(described_class.online).not_to include(face_to_face_courses.first)
      end
    end

    describe 'face_to_face' do
      before do
        [face_to_face_courses, online_courses]
      end

      it 'includes only face-to-face activities' do
        expect(Activity.face_to_face).to match_array(face_to_face_courses)
      end

      it 'does not include actions' do
        expect(Activity.face_to_face).not_to include(online_courses.first)
      end
    end

    describe 'future-learn' do
      before do
        [online_courses, activity]
      end

      it 'includes only future-learn activities' do
        expect(Activity.future_learn).to match_array(online_courses)
      end

      it 'does not include actions' do
        expect(Activity.future_learn).not_to include(activity)
      end
    end

    describe 'stem-learning' do
      before do
        [face_to_face_courses, online_courses]
      end

      it 'includes only stem-learning activities' do
        expect(described_class.stem_learning).to match_array(face_to_face_courses)
      end

      it 'does not include actions' do
        expect(described_class.stem_learning).not_to include(online_courses.first)
      end
    end

    describe 'community' do
      before do
        [community_activity, online_courses]
      end

      it 'includes only community activities' do
        expect(described_class.community.to_a).to include(community_activity)
      end

      it 'does not include actions' do
        expect(described_class.community).not_to include(online_courses.first)
      end
    end

    describe 'system' do
      before do
        [system_activity, activity]
      end

      it 'includes only system activities' do
        expect(described_class.system).to match_array(system_activity)
      end

      it 'does not include actions' do
        expect(described_class.system).not_to include(activity)
      end
    end

    describe 'user_removable' do
      before do
        [removable_activity, activity, diagnostic_tool_activity]
      end

      it 'include future-learn activities' do
        expect(described_class.user_removable).to include(removable_activity)
      end

      it 'does not include stem' do
        expect(described_class.user_removable).not_to include(activity)
      end

      it 'does not include diagnostic download' do
        expect(described_class.user_removable).not_to include(diagnostic_tool_activity)
      end
    end
  end

  describe '.cs_accelerator_diagnostic_tool' do
    it 'returns a record if one is found' do
      activity = create(:activity, :cs_accelerator_diagnostic_tool)
      expect(described_class.cs_accelerator_diagnostic_tool).to eq activity
    end

    it 'creates a record if one is not found' do
      expect(described_class.cs_accelerator_diagnostic_tool.title).to eq 'Taken diagnostic tool'
    end
  end

  describe '#online?' do
    it 'returns true when category is "online"' do
      activity = build(:activity, category: described_class::ONLINE_CATEGORY)
      expect(activity.online?).to eq(true)
    end

    it 'returns false when category is something else' do
      activity = build(:activity, category: described_class::FACE_TO_FACE_CATEGORY)
      expect(activity.online?).to eq(false)
    end
  end
end
