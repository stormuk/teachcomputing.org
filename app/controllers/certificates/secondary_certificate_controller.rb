module Certificates
  class SecondaryCertificateController < ApplicationController
    layout 'full-width'
    before_action :authenticate_user!
    before_action :find_programme, only: %i[show complete pending]
    before_action :user_enrolled?, only: %i[show complete pending]
    before_action :user_programme_enrolment_pending?, only: %i[show complete]

    def show
      return redirect_to complete_secondary_certificate_path if @programme.user_completed?(current_user)

      @programme_activity_groupings = @programme.programme_activity_groupings
      @user_programme_achievements = UserProgrammeAchievements.new(@programme, current_user)

      render :show
    end

    def complete
      return redirect_to secondary_certificate_path unless @programme.user_completed?(current_user)

      @complete_achievements = complete_achievements

      render :complete
    end

    def pending
      return redirect_to complete_secondary_certificate_path if enrolment.current_state == 'complete'

      @complete_achievements = complete_achievements

      render :pending
    end

    private

      def enrolment
        current_user.user_programme_enrolments.find_by(programme_id: @programme.id)
      end

      def complete_achievements
        current_user.achievements.without_category('action')
                    .for_programme(@programme).sort_complete_first
      end

      def find_programme
        @programme = Programme.secondary_certificate
      end

      def user_enrolled?
        redirect_to secondary_path unless @programme.user_enrolled?(current_user)
      end

      def user_programme_enrolment_pending?
        redirect_to pending_secondary_certificate_path if enrolment.in_state?(:pending)
      end
  end
end
