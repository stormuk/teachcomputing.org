require('rest-client')

class Ghost
  def initialize
    @ghost_api_key = ENV['GHOST_CONTENT_API_KEY']
  end

  def get_single_page(slug)
    request = "#{ENV.fetch('GHOST_API_ENDPOINT')}/content/pages/slug/#{slug}/"
    params = {
      key: @ghost_api_key
    }

    begin
      result = Rails.cache.fetch("get_single_page-#{slug}", expires_in: 1.day) do
        RestClient.get(request, params: params).body
      end

      pages = ActiveSupport::JSON.decode(result)
      pages['pages'][0]
    rescue RestClient::NotFound, RestClient::UnprocessableEntity, URI::InvalidURIError
      raise ActiveRecord::RecordNotFound
    rescue StandardError => e
      Sentry.capture_exception(e)
      raise ActiveRecord::RecordNotFound
    end
  end

  def clear_page_cache(slug = nil)
    Rails.cache.delete("get_single_page-#{slug}")
  end

  def get_featured_posts(how_many = 2)
    request = api_url_prefix(:posts)
    params = {
      key: @ghost_api_key,
      filter: 'featured:true',
      limit: how_many,
      fields: 'title,url,feature_image,custom_excerpt,published_at'
    }

    begin
      result = Rails.cache.fetch("get_#{how_many}_featured_posts-#{Date.today}", expires_in: 10.minutes) do
        RestClient.get(request, params: params).body
      end

      featured_posts = ActiveSupport::JSON.decode(result)

      return featured_posts['posts']
    rescue SocketError
      return []
    rescue RestClient::Exception => e
      Sentry.capture_exception(e)
    rescue ActiveSupport::JSON.parse_error
      Sentry.capture_message("Ghost API JSON Parse error for string: #{result}")
    end
    []
  end

  def api_url_prefix(endpoint)
    "#{ENV.fetch('GHOST_API_ENDPOINT')}/content/#{endpoint}/"
  end
end
