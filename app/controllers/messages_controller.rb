class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    if message.save
      redirect_to group_path(message_params[:group_id])
    else
      redirect_to group_path(message_params[:group_id]), alert: 'メッセージが入力されていません'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :group_id).merge(user_id: current_user.id)
  end
end
