class User < ApplicationRecord
  has_many :favorites
  has_many :stocks, through: :favorites
end
