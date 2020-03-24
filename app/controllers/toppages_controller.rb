class ToppagesController < ApplicationController
  def index
    @books = Book.all
  end
  
  def iine
    @book = Book.find(params[:book_id])
    if @book.users == nil
      @book.users = 0
    end
    @book.users += 1
    @book.update
    redirect_to root_path
  end
end
