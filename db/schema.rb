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

ActiveRecord::Schema[7.0].define(version: 2023_11_23_102913) do
  create_table "appopens", force: :cascade do |t|
    t.integer "user_id"
    t.string "source_ip"
    t.string "location"
    t.string "version_name"
    t.string "version_code"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
