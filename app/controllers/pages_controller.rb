class PagesController < ApplicationController
  layout 'full-width'
  before_action :redirect_to_dashboard, only: [:login]

  def page
    render template: "pages/#{params[:page_slug]}"
  end

  def exception
    render template: 'pages/exception', status: params[:status]
  end

  def home
    @ghost_enabled = ghost_enabled?
    @featured_posts = Ghost.new.get_featured_posts(ENV['GHOST_LIMIT_FEATURED_POSTS']) if @ghost_enabled
    render template: 'pages/home/index'
  end

  def login
    auth_uri = '/auth/stem'
    if params[:source_uri].present?
      auth_uri += "?source_uri=#{params[:source_uri]}"
    end
    render template: 'pages/login', locals: { auth_uri: auth_uri }
  end
end
