# encoding: UTF-8
# frozen_string_literal: true
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

ActiveRecord::Schema.define(version: 20_160_323_015_402) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'
  enable_extension 'hstore'

  create_table 'csv_files', force: :cascade do |t|
    t.text     'path'
    t.integer  'dataset_id'
    t.text     'status', default: 'created', null: false
    t.datetime 'created_at',                     null: false
    t.datetime 'updated_at',                     null: false
    t.text     'csv'
  end

  add_index 'csv_files', ['dataset_id'], name: 'index_csv_files_on_dataset_id', using: :btree
  add_index 'csv_files', ['status'], name: 'index_csv_files_on_status', using: :btree

  create_table 'dataset_columns', force: :cascade do |t|
    t.text     'name'
    t.integer  'dataset_id'
    t.text     'column_type'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
  end

  add_index 'dataset_columns', ['column_type'], name: 'index_dataset_columns_on_column_type', using: :btree
  add_index 'dataset_columns', ['dataset_id'], name: 'index_dataset_columns_on_dataset_id', using: :btree
  add_index 'dataset_columns', ['name'], name: 'index_dataset_columns_on_name', using: :btree

  create_table 'dataset_rows', force: :cascade do |t|
    t.integer  'dataset_id'
    t.hstore   'dataset_attributes'
    t.datetime 'created_at',         null: false
    t.datetime 'updated_at',         null: false
  end

  add_index 'dataset_rows', ['dataset_attributes'], name: 'index_dataset_rows_on_dataset_attributes', using: :gin
  add_index 'dataset_rows', ['dataset_id'], name: 'index_dataset_rows_on_dataset_id', using: :btree

  create_table 'datasets', force: :cascade do |t|
    t.text     'title'
    t.datetime 'created_at',                     null: false
    t.datetime 'updated_at',                     null: false
    t.integer  'dataset_rows_count', default: 0, null: false
  end

  add_foreign_key 'csv_files', 'datasets'
  add_foreign_key 'dataset_columns', 'datasets'
  add_foreign_key 'dataset_rows', 'datasets'
end
