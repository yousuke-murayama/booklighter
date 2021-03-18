class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :likes]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @messages = @user.messages
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = '登録しました！'
      redirect_to @user
    else
      flash[:danger] = '登録に失敗しました'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_url
    end
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = '正常に変更されました'
      redirect_to @user
    else
      flash.now[:danger] = '変更されませんでした'
      render :edit
    end
  end
  
  def likes
    @user = User.find(params[:id])
    @like_messages = @user.like_messages
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile, :email, :password, :password_confirmation)
  end
end
