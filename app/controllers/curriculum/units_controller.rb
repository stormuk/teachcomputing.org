module Curriculum
  class UnitsController < ApplicationController
    include Curriculum::Rateable

    layout 'full-width'

    def show
      begin
        redirect = CurriculumClient::Queries::Redirect.one(params[:unit_slug], params[:key_stage_slug])&.redirect
      rescue ActiveRecord::RecordNotFound; end

      redirect_to curriculum_key_stage_unit_path(
        key_stage_slug: redirect[:to_context].first,
        unit_slug: redirect[:to]
      ) and return if redirect.present?

      @unit = CurriculumClient::Queries::Unit.one(params[:unit_slug])&.unit
    end

    protected

      def client
        CurriculumClient::Queries::Unit
      end
  end
end
