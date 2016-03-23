# frozen_string_literal: true
class DataJoin
  include ActiveModel::Model
  include ActiveModel::Serializers::JSON
  extend ActiveModel::Naming

  attr_accessor :dimense, :attribute, :compare_attribute

  def self.wrap(*join_results)
    join_results.map do |join_result|
      DataJoin.new(
        dimense: join_result['dimense'],
        attribute: join_result['attribute'],
        compare_attribute: join_result['compare_attribute'])
    end
  end
end
