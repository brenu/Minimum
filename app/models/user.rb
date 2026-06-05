class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :blog, dependent: :destroy

  accepts_nested_attributes_for :blog

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
