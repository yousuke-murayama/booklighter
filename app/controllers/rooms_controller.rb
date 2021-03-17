class RoomsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @rooms = Room.all
    @room = current_user.rooms.build
  end

  def show
  end

  def create
    @room = current_user.rooms.build(room_params)
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
    params.require(:room).permit(:title)
  end
end
