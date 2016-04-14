# frozen_string_literal: true
class Tag < ApplicationRecord
  validates :key, :value, :name, presence: true
  validates :value, :name, uniqueness: {scope: :key}

  def tag_str
    "#{key}:#{value}"
  end
end
