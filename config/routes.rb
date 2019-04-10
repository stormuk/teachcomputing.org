Rails.application.routes.draw do
  root to: 'pages#home', action: :home

  namespace :achiever do
    delete '/cache', to: 'cache#destroy'
  end

  namespace 'admin' do
    resources :imports
  end

  resources :achievements, only: [:create, :destroy]

  namespace :activities do
    resources :downloads, only: [:show]
  end

  get '/auth/callback', to: 'auth#callback', as: 'callback'

  resources :courses, path: '/courses', only: [:index]

  get 'dashboard', action: :show, controller: 'dashboard'

  get '/about', to: 'pages#page', as: :about, defaults: { page_slug: 'about' }
  get '/accelerator', to: 'pages#page', as: :accelerator, defaults: { page_slug: 'accelerator' }
  get '/bursary', to: 'pages#page', as: :bursary, defaults: { page_slug: 'bursary' }
  get '/certification', to: 'pages#page', as: :certification, defaults: { page_slug: 'certification' }
  get '/contact', to: 'pages#page', as: :contact, defaults: { page_slug: 'contact' }
  get '/get-involved', to: 'pages#page', as: :get_involved, defaults: { page_slug: 'get-involved' }
  get '/login', to: 'pages#login', as: :login
  get '/logout', to: 'auth#logout', as: :logout
  get '/offer', to: 'pages#page', as: :offer, defaults: { page_slug: 'offer' }
  get '/privacy', to: 'pages#page', as: :privacy, defaults: { page_slug: 'privacy' }
  get '/signup-confirmation', to: 'pages#page', as: :signup_confirmation, defaults: { page_slug: 'signup-confirmation' }
  get '/signup-stem', to: 'pages#page', as: :signup_stem, defaults: { page_slug: 'signup-stem' }
  get '/terms-conditions', to: 'pages#page', as: :terms_conditions, defaults: { page_slug: 'terms-conditions' }
  get '/hubs', to: 'pages#page', as: :hubs, defaults: { page_slug: 'hubs' }
  get '/404', to: 'pages#exception', defaults: { format: 'html', status: 404 }
  get '/422', to: 'pages#exception', defaults: { status: 422 }
  get '/500', to: 'pages#exception', defaults: { status: 500 }

  scope '/news' do
    get '/', as: :news, to: redirect('https://blog.teachcomputing.org/tag/news')
    get '/a-level', to: redirect('https://blog.teachcomputing.org/a-level')
    get '/beta-launch', to: redirect('https://blog.teachcomputing.org/beta-launch')
    get '/women-in-stem', to: redirect('https://blog.teachcomputing.org/women-in-stem')
    get '/first-regional-delivery-network', to: redirect('https://blog.teachcomputing.org/first-regional-delivery-network')
  end

  scope '/press' do
    get '/', as: :press, to: redirect('https://blog.teachcomputing.org/tag/press')
    get '/simon-peyton-jones-chair-ncce', to: redirect('https://blog.teachcomputing.org/simon-peyton-jones-chair-ncce')
    get '/bt-rolls-royce-arm-back-ncce', to: redirect('https://blog.teachcomputing.org/bt-rolls-royce-arm-back-ncce')

  end

  get '/external/assets/ncce.css', to: 'asset_endpoint#css_endpoint', as: :css_endpoint

  require 'sidekiq/web'
  if Rails.env.production?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_USERNAME'])) &
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_PASSWORD']))
    end
  end
  mount Sidekiq::Web, at: 'admin/sidekiq'
end
