Twitter.configure do |config|
  config.consumer_key = SETTINGS['twitter_consumer_key']
  config.consumer_secret = SETTINGS['twitter_consumer_secret']
  config.oauth_token = SETTINGS['twitter_oauth_token']
  config.oauth_token_secret = SETTINGS['twitter_oauth_token_secret']
end
