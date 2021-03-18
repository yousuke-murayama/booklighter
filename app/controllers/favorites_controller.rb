class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    message = Message.find(params[:message_id])
    current_user.add_favorite(message)
    flash[:success] = 'お気に入りに追加しました！'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    message = Message.find(params[:message_id])
    current_user.unfavorite(message)
    flash[:success] = 'お気に入りを取り消しました'
    redirect_back(fallback_location: root_path)
  end
end
