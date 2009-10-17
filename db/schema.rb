# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091012023204) do

  create_table "tweets", :force => true do |t|
    t.integer  "observer_id"
    t.integer  "observer_msg_id",        :limit => 8
    t.string   "observer_screen_name"
    t.string   "observer_avatar_url"
    t.string   "observer_msg"
    t.integer  "culprit_id"
    t.integer  "culprit_msg_id",         :limit => 8
    t.string   "culprit_screen_name"
    t.string   "culprit_avatar_url"
    t.string   "culprit_msg"
    t.datetime "observer_msg_timestamp"
    t.datetime "culprit_msg_timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweets", ["culprit_msg_id"], :name => "index_tweets_on_culprit_msg_id"
  add_index "tweets", ["observer_msg_id"], :name => "index_tweets_on_observer_msg_id"

end
