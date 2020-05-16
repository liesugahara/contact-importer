class User < ApplicationRecord
  has_many :uploads
  has_many :contacts
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
