class Tweet < ActiveRecord::Base
  validates_uniqueness_of :observer_msg_id
end
