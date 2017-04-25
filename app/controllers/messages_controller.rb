class MessagesController < ApplicationController
  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      respond_to do |format|
        # これはビュー全体を返すためのやつ
        format.html { redirect_to group_path(@message.group_id) }
        # これは全体ビューに差し込むビューを返してくる
        format.json { render json: message_for_js(@message) }
      end
    else
      redirect_to group_path(message_params[:group_id]), alert: 'メッセージが入力されていません'
    end
  end

  private

  def message_for_js(message)
    {content: message.content, user_name: message.user.name, created_at: message.created_at.strftime('%Y年%m月%d日 %H時%M分')}
  end

  def message_params
    params.require(:message).permit(:content, :group_id)
  end
end
