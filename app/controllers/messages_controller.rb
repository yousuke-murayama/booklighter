class MessagesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @room = Room.find(params[:room_id])
    @message = current_user.messages.build(message_params)
    @message.room_id = @room.id
    
    if @message.save
      flash[:success] = 'メッセージを送信しました'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'メッセージの送信に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @message.destroy
    flash[:success] = 'メッセージを削除しました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content, :room_id)
  end
  
  def correct_user
    @message = current_user.messages.find_by(id: params[:id])
    unless @message
      redirect_to root_url
    end
  end
end
