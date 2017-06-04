class Board < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_many :relationships
  has_many :members, :through => :relationships, :source => :user
  has_many :posts, :dependent => :destroy
end
