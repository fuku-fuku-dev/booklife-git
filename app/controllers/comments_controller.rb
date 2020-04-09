class CommentsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    book = Book.find(params[:book_id])
    @comment = book.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: root_path)
    else
      flash[:success] = "コメントできませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    Comment.find_by(params[:id]).destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def comment_params
    params.require(:comment).permit(:content)
  end
  
  def correct_user
    @comment = current_user.comment.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
end
