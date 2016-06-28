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

ActiveRecord::Schema.define(version: 20160628224724) do

  create_table "allergens", force: :cascade do |t|
    t.string   "nome"
    t.text     "descrizione"
    t.string   "img"
    t.string   "img1"
    t.string   "img2"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "titolo"
    t.text     "descrizione"
    t.string   "foto"
    t.string   "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "ordine"
  end

  create_table "dishes", force: :cascade do |t|
    t.string   "nome"
    t.text     "descrizione"
    t.text     "lista_ingredienti"
    t.string   "img"
    t.string   "img1"
    t.string   "img2"
    t.string   "img3"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string   "nome"
    t.text     "descrizione"
    t.string   "img"
    t.string   "img1"
    t.string   "img2"
    t.string   "allergen_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  add_index "ingredients", ["user_id"], name: "index_ingredients_on_user_id"

  create_table "menus", force: :cascade do |t|
    t.string   "nome"
    t.text     "descrizione"
    t.string   "categorie"
    t.string   "piatti"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "tipo"
    t.string   "descrizione"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "stampalistino",      default: false
    t.datetime "stampalistino_data"
    t.boolean  "weblistino",         default: false
    t.datetime "weblistino_data"
  end

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
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
