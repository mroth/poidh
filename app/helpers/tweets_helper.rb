module TweetsHelper
  
  def linked_screenname(screenname)
    link_to screenname, twitter_member_url(screenname)
  end
  
  def twitter_member_url(screenname)
    "http://twitter.com/" + screenname
  end
  
  def twitter_avatar_img(screenname)
    image_tag("http://twivatar.org/" + screenname, :size => '48x48', :alt => screenname)
  end
  
  def twitter_avatar_mini_img(screenname)
    image_tag("http://twivatar.org/" + screenname + "/mini", :size => "24x24", :alt => screenname)
  end
  
end
