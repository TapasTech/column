# frozen_string_literal: true
class User < ApplicationRecord
  validates :email, presence: true
  has_many :csv_files
  has_many :datasets, through: :csv_files
  has_secure_password
end
