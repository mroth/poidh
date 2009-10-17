class IndexTimestamps < ActiveRecord::Migration
  def self.up
    add_index :tweets, :observer_msg_timestamp
    add_index :tweets, :culprit_msg_timestamp
  end

  def self.down
    remove_index :tweets, :observer_msg_timestamp
    remove_index :tweets, :culprit_msg_timestamp   
  end
end
