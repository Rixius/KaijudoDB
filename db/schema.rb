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

ActiveRecord::Schema.define(version: 20140418184922) do

  create_table "abilities", force: true do |t|
    t.string   "name",       limit: 100
    t.string   "text"
    t.string   "icon",       limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cards", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "power"
    t.integer  "cost"
    t.string   "flavor"
    t.string   "art"
    t.string   "illustrator"
    t.integer  "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cards_abilities", force: true do |t|
    t.integer "card_id"
    t.integer "ability_id"
  end

  create_table "cards_civs", force: true do |t|
    t.integer "card_id"
    t.integer "civ_id"
  end

  create_table "cards_races", force: true do |t|
    t.integer "card_id"
    t.integer "race_id"
  end

  create_table "cardsets", force: true do |t|
    t.string   "name"
    t.string   "short",      limit: 50
    t.date     "released"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "civs", force: true do |t|
    t.string   "name"
    t.string   "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "printings", force: true do |t|
    t.integer  "card_id"
    t.integer  "cardset_id"
    t.integer  "rarity"
    t.string   "number",     limit: 25
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "races", force: true do |t|
    t.string   "name",       limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
