class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  has_one_attached :image
  
  has_many :books
  has_many :favorites
  has_many :fav_books, through: :favorites, source: :book
  has_many :comments
  has_many :book_comments, through: :comments, source: :book
  
  def favorite(book)
    self.favorites.find_or_create_by(book_id: book.id)
  end
  
  def unfavorite(book)
   favorite = self.favorites.find_by(book_id: book.id)
   favorite.destroy if favorite
  end

  def fav_book?(book)
    self.fav_books.include?(book)
  end
  
  def comment(book)
    self.comments.find_or_create_by(book_id: book.id)
  end  
  
end
