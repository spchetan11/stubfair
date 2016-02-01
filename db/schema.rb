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

ActiveRecord::Schema.define(version: 20160201143720) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
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

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "bands", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.float    "value"
    t.integer  "user_id"
  end

  add_index "bands", ["user_id"], name: "index_bands_on_user_id"

  create_table "catergories", force: :cascade do |t|
    t.string   "category_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "event_images", force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "event_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.text     "image_url"
  end

  add_index "event_images", ["event_id"], name: "index_event_images_on_event_id"

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "venue"
    t.datetime "event_date_time"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "user_id"
    t.boolean  "published",                  default: false
    t.string   "category"
    t.string   "location"
    t.text     "stadium_image_url"
    t.string   "stadium_image_file_name"
    t.string   "stadium_image_content_type"
    t.integer  "stadium_image_file_size"
    t.datetime "stadium_image_updated_at"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "pictures", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "event_id"
    t.text     "image_url"
  end

  add_index "pictures", ["event_id"], name: "index_pictures_on_event_id"

  create_table "popular_events", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "image_url"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "type"
    t.integer  "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ticket_images", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "ticket_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "image_url"
  end

  add_index "ticket_images", ["ticket_id"], name: "index_ticket_images_on_ticket_id"

  create_table "tickets", force: :cascade do |t|
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "user_id"
    t.integer  "number_of_tickets"
    t.float    "ticket_selling_price"
    t.string   "ticket_number"
    t.boolean  "published",                   default: false
    t.float    "ticket_printed_price"
    t.string   "ticket_type"
    t.integer  "event_id"
    t.string   "section"
    t.string   "row"
    t.string   "seat_number"
    t.string   "booking_id"
    t.integer  "number_of_tickets_purchased", default: 0
  end

  add_index "tickets", ["event_id"], name: "index_tickets_on_event_id"
  add_index "tickets", ["user_id"], name: "index_tickets_on_user_id"

  create_table "transactions", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "user_id"
    t.integer  "ticket_id"
    t.datetime "expires_on"
    t.float    "purchase_amount"
    t.string   "comments"
    t.integer  "number_of_tickets"
    t.float    "ticket_printed_price"
    t.string   "ticket_number"
    t.boolean  "published"
    t.integer  "event_id"
    t.float    "ticket_selling_price"
    t.float    "sale_amount"
    t.string   "ticket_type"
    t.datetime "ticket_created_at"
    t.datetime "ticket_updated_at"
    t.boolean  "purchased"
    t.integer  "number_of_tickets_purchased"
    t.text     "notification_params"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "purchased_at"
    t.integer  "seller_id"
    t.string   "booking_id"
  end

  add_index "transactions", ["event_id"], name: "index_transactions_on_event_id"
  add_index "transactions", ["ticket_id"], name: "index_transactions_on_ticket_id"
  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id"

  create_table "trusted_users", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "gender"
    t.string   "phone"
    t.integer  "age"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "last_name"
    t.text     "address"
    t.integer  "postcode"
    t.integer  "buyer_band",             default: 1
    t.integer  "seller_band",            default: 1
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
