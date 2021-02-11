module Diagnostics
  class PrimaryCertificateController < BaseController
    before_action :authenticate, :questionnaire
    before_action :enrolled?, :completed_diagnostic?, only: %i[show]

    steps :question_1, :question_2, :question_3, :question_4

    def show
      @programme = programme
      @step = step
      @steps = steps
      @answer = answer_for_current_step

      render_wizard nil, template: '/diagnostics/primary_certificate/questions'
    end

    def update
      response = questionnaire_response
      store_response response

      if finished?
        response.complete!
        redirect_to finish_wizard_path
      else
        jump_to_latest response
        render_wizard response
      end
    end

    private

      def programme
        Programme.find_by(slug: 'primary-certificate')
      end

      def questionnaire
        Questionnaire.find_by!(slug: 'primary-certificate-enrolment-questionnaire')
      end

      def enrolled?
        redirect_to primary_path unless programme.user_enrolled?(current_user)
      end
  end
end
