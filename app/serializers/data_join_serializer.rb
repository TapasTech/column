# frozen_string_literal: true
class DataJoinSerializer < ActiveModel::Serializer
  attributes :dimense, :attribute, :compare_attribute
end
