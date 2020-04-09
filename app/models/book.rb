class Book < ApplicationRecord
  belongs_to :user
  
  validates :explain, presence: true, length: { maximum: 255 }
  validates :change, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }
  
  #has_one_attached :image
  mount_uploader :image, ImageUploader
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy
  has_many :user_comments, through: :comments, source: :user
end
