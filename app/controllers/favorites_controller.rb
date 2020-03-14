class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    current_user.favorite(book)
    flash[:success] = 'お気に入りに追加しました。'
    redirect_to root_path
  end

  def destroy
    book = Book.find(params[:book_id])
    current_user.unfavorite(book)
    flash[:success] = 'お気に入りを外しました。'
    redirect_to root_path
  end
end
