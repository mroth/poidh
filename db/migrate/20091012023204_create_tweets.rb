class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.integer :observer_id
      t.integer :observer_msg_id
      t.string :observer_screen_name
      t.string :observer_avatar_url
      t.string :observer_msg
      t.integer :culprit_id
      t.integer :culprit_msg_id
      t.string :culprit_screen_name
      t.string :culprit_avatar_url
      t.string :culprit_msg
      t.datetime :observer_msg_timestamp
      t.datetime :culprit_msg_timestamp

      t.timestamps
    end
    
    add_index :tweets, :observer_msg_id
    add_index :tweets, :culprit_msg_id
  end

  def self.down
    drop_table :tweets
  end
end
