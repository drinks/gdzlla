require 'oauth'
require 'twitter'
require 'flickr_fu'

module OAuthable
  def twitter_consumer
    @@consumer ||= OAuth::Consumer.new(setting(:twitter_consumer_key), setting(:twitter_consumer_secret), site: twitter_client.endpoint)
  end

  def twitter_client
    @@twitter = Twitter::Client.new
  end

  def flickr_client
    @@flickr ||= Flickr.new(key: setting(:flickr_key), secret: setting(:flickr_secret))
  end
end
