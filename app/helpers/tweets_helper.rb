module TweetsHelper
  
  def linked_screenname(screenname)
    link_to screenname, twitter_member_url(screenname)
  end
  
  def twitter_member_url(screenname)
    "http://twitter.com/" + screenname
  end
end
