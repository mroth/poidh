class CreateSearches < ActiveRecord::Migration
  def self.up
    create_table :searches do |t|
      t.integer :candidates
      t.integer :matched
      t.integer :rejected_private
      t.integer :rejected_not_reply
      t.integer :rejected_already_indexed
      t.integer :most_recent_seen
      
      t.timestamps
    end
  end

  def self.down
    drop_table :searches
  end
end
