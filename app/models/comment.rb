class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  validates :user_id, presence: true
  validates :book_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
end
