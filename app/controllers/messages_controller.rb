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
      redirect_to group_path(message_params[:group_id]), alert: 'メッセージか画像が入力されていません'
    end
  end

  def reload
    # 「idがビューに表示されているidより大きい&&group_idが今のグループ&&user_idが今のユーザーでない」レコードを探す。配列になる
    # 配列の中身をJSで扱える形に加工する
    new_messages = Message.where("id > #{params[:message_id]}", group_id: params[:group_id]).where.not(user_id: current_user.id).map{ |new_message| message_for_js(new_message) }
    respond_to do |format|
      format.json { render json: new_messages }
    end
  end

  private

  def message_for_js(message)
    hash = { user_name: message.user.name, created_at: message.created_at.strftime('%Y年%m月%d日 %H時%M分'), id: message.id }
    if message.content.present? && message.image.present?
      return hash.merge({ content: message.content, image: message.image.to_s })
    elsif message.content.present?
      return hash.merge({ content: message.content })
    else
      return hash.merge({ image: message.image.to_s })
    end
  end

  def message_params
    params.require(:message).permit(:content, :group_id, :image)
  end
end
