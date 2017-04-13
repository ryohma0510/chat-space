class MessagesController < ApplicationController
  def create
    if current_user.messages.new(message_params).save
      redirect_to group_path(message_params[:group_id])
    else
      redirect_to group_path(message_params[:group_id]), alert: 'メッセージが入力されていません'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :group_id)
  end
end
