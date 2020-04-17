require 'rails_helper'

RSpec.describe AssessmentAttemptsController do
  let(:user) { create(:user) }
  let(:assessment) { create(:assessment) }

  describe 'POST #create' do
    before do
      user
      assessment
      allow_any_instance_of(AuthenticationHelper).to receive(:current_user).and_return(user)
    end

    context 'with valid params' do
      it 'creates an assessment attempt record' do
        post assessment_attempts_path(assessment_attempt: { assessment_id: assessment.id, user_id: user.id })
        expect(AssessmentAttempt.where(assessment_id: assessment.id, user_id: user.id).exists?).to eq true
      end

      it 'redirects to the assessment link path' do
        post assessment_attempts_path(assessment_attempt: { assessment_id: assessment.id, user_id: user.id })
        expect(response).to redirect_to("#{assessment.link}&cm_e=#{user.email}&cm_user_id=#{user.id}")
      end


      it 'queues ExpireAssessmentAttemptJob job' do
        expect do
          post assessment_attempts_path(assessment_attempt: { assessment_id: assessment.id, user_id: user.id })
        end.to have_enqueued_job(ExpireAssessmentAttemptJob)
      end

      it 'doesn\'t store trn if not present' do
        post assessment_attempts_path(assessment_attempt: { assessment_id: assessment.id, user_id: user.id })
        expect(user.teacher_reference_number).to be(nil)
      end

      it 'stores the trn if it is present' do
        path = assessment_attempts_path(assessment_attempt: {
                                          assessment_id: assessment.id,
                                          user_id: user.id
                                        })
        post path, params: {
                      user: {
                        teacher_reference_number: 'abc123'
                      }
                    }
        expect(user.teacher_reference_number).to eq('abc123')
      end
    end

    context 'with invalid params' do
      it 'raises ActiveRecord::RecordNotFound exception' do
        expect do
          post assessment_attempts_path(assessment_attempt: { assessment_id: nil, user_id: nil })
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
