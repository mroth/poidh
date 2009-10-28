class Search < ActiveRecord::Base
  validates_presence_of [:candidates, :matched, :rejected_private, :rejected_not_reply, :rejected_already_indexed]
end
