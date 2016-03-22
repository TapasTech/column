# frozen_string_literal: true
FactoryGirl.define do
  factory :dataset_column do
    name 'MyText'
    dataset nil
    column_type 'MyText'
  end
end
