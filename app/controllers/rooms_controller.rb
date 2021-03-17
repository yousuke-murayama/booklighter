class RoomsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @rooms = Room.all
    @room = current_user.rooms.build(user_id: current_user.id)
  end

  def show
    @room = Room.find(params[:id])
    @message = current_user.messages.build(room_id: @room.id)
    @messages = @room.messages
  end

  def create
    @room = current_user.rooms.build(room_params)
    @room.user_id = current_user.id
    if @room.save
      flash[:success] = 'トークルームを作成しました！'
      redirect_to rooms_path
    else
      flash[:danger] = '作成できませんでした'
      redirect_to rooms_path
    end
  end
  
  private
  
  def room_params
    params.require(:room).permit(:title, :user_id)
  end
end
