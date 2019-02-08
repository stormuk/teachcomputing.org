SitemapGenerator::Sitemap.default_host = 'https://teachcomputing.org'
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(fog_provider: 'AWS',
                                                                    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                                                                    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                                                                    fog_directory: ENV['AWS_S3_BUCKET'],
                                                                    fog_region: ENV['AWS_S3_REGION'])
SitemapGenerator::Sitemap.sitemaps_host = "https://s3-#{ENV['AWS_S3_REGION']}.amazonaws.com/#{ENV['AWS_S3_BUCKET']}/"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.create_index = false
SitemapGenerator::Sitemap.create do
  add '/', changefreq: 'daily'
  add '/about', changefreq: 'monthly'
  add '/accelerator', changefreq: 'monthly'
  add '/certification', changefreq: 'monthly'
  add '/contact', changefreq: 'monthly'
  add '/login', changefreq: 'monthly'
  add '/news', changefreq: 'daily'
  add '/news/a-level', changefreq: 'monthly'
  add '/offer', changefreq: 'monthly'
  add '/privacy', changefreq: 'monthly'
  add '/signup-stem', changefreq: 'monthly'
  add '/terms-conditions', changefreq: 'monthly'
end
