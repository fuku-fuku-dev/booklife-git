class BooksController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @books = current_user.books.order(id: :desc).page(params[:page]).per(25)
  end  
  
  def show
    @book = Book.find(params[:id])
  end 
  
  def new
    @book = Book.new
  end  
  
  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      @books = current_user.books.order(id: :desc).page(params[:page])
      flash.now[:danger] = '投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @book.destroy
    flash[:success] = '削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def new_books
    @books = Book.all.order(id: :desc).page(params[:page]).per(25)
  end
  
  def old_books
    @books = Book.all.order(id: :desc).page(params[:page]).per(25)
  end
  
  def many_favorites
    @books = Book.find(Favorite.group(:book_id).order('count(book_id) desc').limit(25).pluck(:book_id))
  end
  
  def my_favorites
    @books = Book.where(id: current_user.fav_books).order(id: :asc).page(params[:page]).per(25)
  end  
  
  private

  def book_params
    params.require(:book).permit(:explain, :change, :title)
  end
  
  def correct_user
    @book = current_user.books.find_by(id: params[:id])
    unless @book
      redirect_to root_url
    end
  end
end
