# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TweetButton
  
  #moving this into a helper method means we need to call twitter_widgets_js_tag in the header of template
  def my_tweet_button(tweet)
    tweet_button( 
			:text => "POIDH @#{tweet.culprit_screen_name}\: \""+ tweet.culprit_msg +  "\"", 
			:via => 'poidhdotorg', 
			:count => 'none', 
			:url => 'http://poidh.org' + tweet_path(tweet),
			:related => tweet.culprit_screen_name
		)
  end
end
