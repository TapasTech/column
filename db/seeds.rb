# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ds = Dataset.create(title: '2015年上海平均房价月度统计')
ds.dataset_columns.create(name: 'month', column_type: :numeric)
ds.dataset_columns.create(name: 'price', column_type: :numeric)
ds.dataset_rows.create(dataset_attributes: {month: '03', price: '32426'})
ds.dataset_rows.create(dataset_attributes: {month: '04', price: '32509'})
ds.dataset_rows.create(dataset_attributes: {month: '05', price: '33263'})
ds.dataset_rows.create(dataset_attributes: {month: '06', price: '33727'})
ds.dataset_rows.create(dataset_attributes: {month: '07', price: '34118'})
ds.dataset_rows.create(dataset_attributes: {month: '08', price: '35405'})
ds.dataset_rows.create(dataset_attributes: {month: '09', price: '35451'})
ds.dataset_rows.create(dataset_attributes: {month: '10', price: '35644'})
ds.dataset_rows.create(dataset_attributes: {month: '11', price: '36143'})
ds.dataset_rows.create(dataset_attributes: {month: '12', price: '36935'})

ds = Dataset.create(title: '2015年上证指数每月平均收盘价')
ds.dataset_columns.create(name: 'month', column_type: :numeric)
ds.dataset_columns.create(name: 'index', column_type: :numeric)
ds.dataset_rows.create(dataset_attributes: {month: '03', index: '3483.94'})
ds.dataset_rows.create(dataset_attributes: {month: '04', index: '4186.23'})
ds.dataset_rows.create(dataset_attributes: {month: '05', index: '4467.84'})
ds.dataset_rows.create(dataset_attributes: {month: '06', index: '4798.02'})
ds.dataset_rows.create(dataset_attributes: {month: '07', index: '3848.25'})
ds.dataset_rows.create(dataset_attributes: {month: '08', index: '3594.02'})
ds.dataset_rows.create(dataset_attributes: {month: '09', index: '3127.99'})
ds.dataset_rows.create(dataset_attributes: {month: '10', index: '3342.48'})
ds.dataset_rows.create(dataset_attributes: {month: '11', index: '3561.20'})
ds.dataset_rows.create(dataset_attributes: {month: '12', index: '3546.04'})
