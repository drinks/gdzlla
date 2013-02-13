class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id,              type: Integer  # twitter id, to keep posts correlated when sn changes
  field :username,             type: String
  field :url_type,             type: Symbol,  default: :gdzlla
  field :strip_tags,           type: Boolean, default: false
  field :photoset,             type: String
  field :flickr_token,         type: String
  field :twitter_token,        type: String
  field :twitter_secret,       type: String

  has_many :posts, :dependent => :destroy

  index username: 1

  def to_param
    username
  end

  def flickr_token=(token)
    @flickr = nil
    @photosets = nil
    super token
  end

  def strip_tags?
    strip_tags
  end

  def twitter_token=(token)
    @twitter = nil
    super token
  end

  def twitter_secret=(secret)
    @twitter = nil
    super secret
  end

  def photosets
    @photosets ||= flickr_client.photosets.get_list rescue nil
  end

  def timeline
    @timeline ||= twitter_client.user_timeline username
  end

  # protected

  def flickr_client
    client_opts = {key: GDZLLA.setting(:flickr_key), secret: GDZLLA.setting(:flickr_secret)}
    client_opts.merge!(token: flickr_token) unless flickr_token.blank?
    @flickr ||= Flickr.new(client_opts)
  end

  def twitter_client
    @twitter ||= Twitter::Client.new(oauth_token: twitter_token, oauth_token_secret: twitter_secret)
  end

end