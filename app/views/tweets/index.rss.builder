xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "POIDH"
    xml.description "Things people want pics of (from twitter!)"
    xml.link formatted_tweets_url(:rss)
    
    for tweet in @tweets
      xml.item do
        xml.title "@#{tweet.observer_screen_name} wants pics from @#{tweet.culprit_screen_name}"
        xml.description "#{twitter_avatar_mini_img tweet.culprit_screen_name}: #{tweet.culprit_msg}"
        xml.pubDate tweet.created_at.to_s(:rfc822)
        xml.link tweet_url(tweet)
        xml.guid tweet_url(tweet)
      end
    end
  end
end

