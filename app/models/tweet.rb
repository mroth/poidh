class Tweet < ActiveRecord::Base
  validates_uniqueness_of :observer_msg_id
  validates_uniqueness_of :culprit_msg_id
  
  def observer_msg_url
    return "http://twitter.com/" + observer_screen_name + "/status/" + observer_msg_id.to_s
  end
  
  def culprit_msg_url
    return "http://twitter.com/" + culprit_screen_name + "/status/" + culprit_msg_id.to_s
  end
  
end
