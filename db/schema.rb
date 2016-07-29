# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160726085902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "feed_histories", force: :cascade do |t|
    t.integer  "feed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "feed_histories", ["feed_id"], name: "index_feed_histories_on_feed_id", using: :btree

  create_table "feed_history_has_posts", force: :cascade do |t|
    t.integer  "feed_history_id"
    t.integer  "post_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "feed_history_has_posts", ["feed_history_id"], name: "index_feed_history_has_posts_on_feed_history_id", using: :btree
  add_index "feed_history_has_posts", ["post_id"], name: "index_feed_history_has_posts_on_post_id", using: :btree

  create_table "feeds", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "feeds", ["user_id"], name: "index_feeds_on_user_id", using: :btree

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "pending"
    t.boolean  "accepted"
    t.boolean  "read"
  end

  create_table "groups", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "admin_id"
    t.string   "title"
    t.string   "imageSource"
    t.string   "short_description"
  end

  create_table "groups_have_tags", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "groups_have_tags", ["group_id"], name: "index_groups_have_tags_on_group_id", using: :btree
  add_index "groups_have_tags", ["tag_id"], name: "index_groups_have_tags_on_tag_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "actor_id"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "seen"
    t.integer  "message_type"
  end

  add_index "notifications", ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable_type_and_notifiable_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "text"
    t.integer  "wall_id"
    t.integer  "user_id"
    t.integer  "score"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree
  add_index "posts", ["wall_id"], name: "index_posts_on_wall_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "birthday"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "group_id"
  end

  add_index "subscriptions", ["group_id"], name: "index_subscriptions_on_group_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_friends_preferences", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "entries",                 array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_friends_preferences", ["user_id"], name: "index_user_friends_preferences_on_user_id", using: :btree

  create_table "user_interests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_interests", ["tag_id"], name: "index_user_interests_on_tag_id", using: :btree
  add_index "user_interests", ["user_id"], name: "index_user_interests_on_user_id", using: :btree

  create_table "user_likes_posts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "user_likes_posts", ["likeable_type", "likeable_id"], name: "index_user_likes_posts_on_likeable_type_and_likeable_id", using: :btree
  add_index "user_likes_posts", ["user_id"], name: "index_user_likes_posts_on_user_id", using: :btree

  create_table "user_popularities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "likers",                  array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_popularities", ["user_id"], name: "index_user_popularities_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "likers_count"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "walls", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "walled_id"
    t.string   "walled_type"
  end

  add_index "walls", ["walled_id"], name: "index_walls_on_walled_id", using: :btree

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "feed_histories", "feeds"
  add_foreign_key "feed_history_has_posts", "feed_histories"
  add_foreign_key "feed_history_has_posts", "posts"
  add_foreign_key "feeds", "users"
  add_foreign_key "groups", "users", column: "admin_id"
  add_foreign_key "groups_have_tags", "groups"
  add_foreign_key "groups_have_tags", "tags"
  add_foreign_key "notifications", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "posts", "walls"
  add_foreign_key "profiles", "users"
  add_foreign_key "subscriptions", "groups"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "user_friends_preferences", "users"
  add_foreign_key "user_interests", "tags"
  add_foreign_key "user_interests", "users"
  add_foreign_key "user_likes_posts", "users"
  add_foreign_key "user_popularities", "users"
end
