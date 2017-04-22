class MessagesController < ApplicationController
  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_path(@message.group_id) }
        format.json { render json: @message }
      end
    else
      redirect_to group_path(message_params[:group_id]), alert: 'メッセージが入力されていません'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :group_id)
  end
end
