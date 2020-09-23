module Admin
  class ActivitiesController < AdminController
    def index
      activities = Activity.all
      render json: as_json(activities)
    end

    private

      def as_json(user)
        user.as_json(include: :programmes)
      end
  end
end
