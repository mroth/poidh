module TweetButton
  TWITTER_SHARE_URL = "http://twitter.com/share"
  
  def tweet_button(options = {})
    # Merge user specified overrides into defaults, then convert those to data-* attrs
    params = options_to_data_params(default_tweet_button_options.merge(options))
    
    html = html_safe_string('')
    
    unless @widgetized
      html << tweet_widgets_js_tag
    end
    
    html << link_to("Tweet", TWITTER_SHARE_URL, params)
  end
  
  class <<self
    attr_accessor :default_tweet_button_options
  end
  
  def default_tweet_button_options
    {
      :url => request.url, 
      :via => "tweetbutton", 
      :text => "", 
      :related => "", 
      :count => "vertical", 
      :lang => "en"
    }.merge(TweetButton.default_tweet_button_options || {})
  end
  
  def tweet_widgets_js_tag
    @widgetized = true
    html_safe_string('<script src="http://platform.twitter.com/widgets.js" type="text/javascript"></script>')
  end
  
  alias_method :twitter_widgets_js_tag, :tweet_widgets_js_tag
  
  def custom_tweet_button(text = 'Tweet', options = {}, html_options = {})
    # This line is really long.  And it makes me sad.
    link_to(text, "#{TWITTER_SHARE_URL}?#{options_to_query_string(default_tweet_button_options.merge(options))}", html_options)
  end
  
  def options_to_data_params(opts)
    params = {}
    opts.each {|k, v| params["data-#{k}"] = v}
    
    # Make sure the CSS class is there
    params['class'] = 'twitter-share-button'
    params
  end
  
  # I'm pretty sure this is in the stdlib or Rails somewhere.  Too lazy to figure it out now.
  def options_to_query_string(opts)
    opts.map{|k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v)}"}.join("&")
  end
  
  def html_safe_string(str)
    @use_html_safe ||= "".respond_to?(:html_safe)
    @use_html_safe ? str.html_safe : str
  end
end