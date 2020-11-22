# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_22_212423) do

  create_table "appointments", force: :cascade do |t|
    t.integer "staff_id"
    t.integer "patient_id"
    t.string "appointment_date"
    t.string "diagnosis_note"
  end

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.integer "patient_id"
    t.integer "staff_id"
    t.datetime "created_at", precision: 6, default: "2020-11-22 22:01:37", null: false
    t.datetime "updated_at", precision: 6, default: "2020-11-22 22:01:37", null: false
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "dob"
    t.string "phone"
    t.string "address"
  end

  create_table "prescriptions", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "appointment_id"
    t.integer "patient_id"
  end

  create_table "staffs", force: :cascade do |t|
    t.string "name"
    t.string "dob"
    t.boolean "is_doctor"
    t.string "medical_id"
    t.string "speciality"
    t.string "address"
    t.string "phone"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "dob"
    t.integer "patient_id"
    t.integer "staff_id"
  end

end
