class Book < ApplicationRecord
  belongs_to :user
  
  validates :explain, presence: true, length: { maximum: 255 }
  validates :chanse, presence: true, length: { maximum: 255 }
end
