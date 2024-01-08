# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_01_08_101738) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "appopens", force: :cascade do |t|
    t.integer "user_id"
    t.string "source_ip"
    t.string "location"
    t.string "version_name"
    t.string "version_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contents", force: :cascade do |t|
    t.string "title"
    t.string "release_date"
    t.string "genre"
    t.string "category"
    t.string "banner"
    t.string "trailer_link"
    t.string "language"
    t.boolean "is_slider", default: false
    t.boolean "vip_status", default: true
    t.boolean "status", default: false
    t.integer "views"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.string "code"
    t.string "offer"
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "episodes", force: :cascade do |t|
    t.integer "content_id"
    t.integer "season"
    t.string "url"
    t.string "thumbnail"
    t.string "title"
    t.string "runtime"
    t.string "cast"
    t.string "director"
    t.text "story"
    t.boolean "vip_status", default: true
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "help_desks", force: :cascade do |t|
    t.string "question"
    t.text "answer"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "histories", force: :cascade do |t|
    t.integer "user_id"
    t.integer "episode_id"
    t.boolean "watch_list"
    t.boolean "favorite_list"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payement_details", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "subscription_id", null: false
    t.string "order_id"
    t.string "payement_id"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_id"], name: "index_payement_details_on_subscription_id"
    t.index ["user_id"], name: "index_payement_details_on_user_id"
  end

  create_table "play_times", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "episode_id", null: false
    t.string "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_play_times_on_episode_id"
    t.index ["user_id", "episode_id"], name: "index_play_times_on_user_id_and_episode_id", unique: true
    t.index ["user_id"], name: "index_play_times_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", limit: 50
    t.integer "age"
    t.string "gender", limit: 15
    t.string "mobile", limit: 15
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.integer "user_id"
    t.integer "content_id"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscription_histories", force: :cascade do |t|
    t.integer "user_id"
    t.integer "subscription_id"
    t.string "subscription_start"
    t.string "subscription_end"
    t.integer "coupon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "pending1"
    t.integer "payement_detail_id", null: false
    t.index ["payement_detail_id"], name: "index_subscription_histories_on_payement_detail_id"
    t.index ["user_id"], name: "index_subscription_histories_on_user_id", unique: true, where: "status = 'active'"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "name"
    t.string "real_amount"
    t.string "offer_amount"
    t.string "duration"
    t.boolean "status", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "social_id"
    t.text "social_token"
    t.string "social_type"
    t.string "social_imgurl"
    t.string "social_email"
    t.string "social_name"
    t.string "device_id"
    t.string "device_name"
    t.string "device_type"
    t.string "security_token"
    t.string "advertising_id"
    t.string "referral_code"
    t.string "version_name"
    t.string "version_code"
    t.string "location"
    t.string "source_ip"
    t.text "fcm_token"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "utm_gclid"
    t.string "mobile_number"
    t.string "content_language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "watchlists", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "episode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_watchlists_on_episode_id"
    t.index ["user_id", "episode_id"], name: "index_watchlists_on_user_id_and_episode_id", unique: true
    t.index ["user_id"], name: "index_watchlists_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "payement_details", "subscriptions"
  add_foreign_key "payement_details", "users"
  add_foreign_key "play_times", "episodes"
  add_foreign_key "play_times", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "subscription_histories", "payement_details"
  add_foreign_key "watchlists", "episodes"
  add_foreign_key "watchlists", "users"
end
