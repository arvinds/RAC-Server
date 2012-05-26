# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110504155858) do

  create_table "contents", :force => true do |t|
    t.string   "guid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       :null => false
    t.string   "metadata"
  end

  create_table "requests", :force => true do |t|
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "requester_id",     :null => false
    t.integer  "content_owner_id", :null => false
    t.integer  "content_id",       :null => false
    t.string   "action",           :null => false
    t.string   "obligation_text"
    t.string   "guid"
    t.datetime "obligation_date"
  end

  create_table "users", :force => true do |t|
    t.string   "guid",                             :null => false
    t.string   "last_name",                        :null => false
    t.string   "first_name",                       :null => false
    t.string   "persistence_token",                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "password"
    t.string   "crypted_password"
    t.integer  "user_type",         :default => 0
    t.string   "fbid"
  end

end
