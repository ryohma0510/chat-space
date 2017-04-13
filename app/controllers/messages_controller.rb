class MessagesController < ApplicationController
  def create
    Message.create(message_params)
    redirect_to group_path(message_params[:group_id])
  end

  private

  def message_params
    params.require(:message).permit(:content, :group_id).merge(user_id: current_user.id)
  end
end
