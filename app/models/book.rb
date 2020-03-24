class Book < ApplicationRecord
  belongs_to :user
  
  validates :explain, presence: true, length: { maximum: 255 }
  validates :change, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites, source: :user
end
