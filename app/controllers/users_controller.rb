class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :likes]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.order(id: :desc).page(params[:page]).per(25)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if image = params[:user][:image]
      @user.image.attach(image)
    end
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to root_path
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end  
  end
  
  def update
    current_user.update params.require(:user).permit(:image)
    redirect_to root_path
  end
  
  def likes
    @user = User.find(params[:id])
    @books = Book.where(id: @user.fav_books).order(id: :desc).page(params[:page]).per(25)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end
