class ApplicationController < ActionController::Base
  include AuthenticationHelper

  before_action :authenticate
  before_action :cs_10_hours_enabled

  def authenticate
    return unless ENV['BASIC_AUTH_PASSWORD']

    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def authenticate_user!
    redirect_to(helpers.create_account_url) unless current_user
  end

  def cs_10_hours_enabled
    @cs_10_hours_enabled = ActiveModel::Type::Boolean.new.cast(ENV.fetch('CSA_10_HOUR_JOURNEY_ENABLED'))
  end

  def redirect_to_dashboard
    redirect_to dashboard_path if current_user
  end
end
