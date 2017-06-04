class Post < ApplicationRecord
  belongs_to :user
  belongs_to :board
  has_many :comments
end
