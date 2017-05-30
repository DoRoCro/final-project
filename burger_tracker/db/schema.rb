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

ActiveRecord::Schema.define(version: 20170518091936) do

  create_table "addresses", force: :cascade do |t|
    t.string   "street_addr"
    t.string   "street"
    t.string   "area"
    t.string   "city"
    t.string   "post_code"
    t.string   "phone_no"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "burger_deals", force: :cascade do |t|
    t.integer  "burger_id"
    t.integer  "deal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "burgers", force: :cascade do |t|
    t.string   "description"
    t.integer  "restaurant_id"
    t.decimal  "price",         precision: 5, scale: 2
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "burgers", ["restaurant_id"], name: "index_burgers_on_restaurant_id"

  create_table "deals", force: :cascade do |t|
    t.string   "label"
    t.decimal  "discount_rate"
    t.decimal  "money_off"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "restaurant_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "deals", ["restaurant_id"], name: "index_deals_on_restaurant_id"

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "ratingable_id"
    t.string   "ratingable_type"
    t.integer  "rating"
    t.text     "comment"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "ratings", ["ratingable_type", "ratingable_id"], name: "index_ratings_on_ratingable_type_and_ratingable_id"
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id"

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.integer  "address_id"
    t.string   "franchise"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "restaurants", ["address_id"], name: "index_restaurants_on_address_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
