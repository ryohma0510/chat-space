require 'rails_helper'

describe MessagesController, type: :controller do

  let(:user)    { create(:user) }
  let(:group)   { create(:group) }
  let(:message) { { message: attributes_for(:message, user_id: user.id, group_id: group.id) } }

  before do
    login_user user
  end

  describe 'POST #create' do
    it 'redirects groups#show when a content of message exists' do
      post :create, message
      expect(response).to redirect_to "/groups/#{group.id}"
    end

    it 'redirects groups#show when a content of message is nil' do
      post :create, { message: attributes_for(:message,content: '', user_id: user.id, group_id: group.id) }
      expect(response).to redirect_to "/groups/#{group.id}"
    end

    it 'alerts when a content of message is nil' do
     post :create, { message: attributes_for(:message,content: '', user_id: user.id, group_id: group.id) }
     expect(flash[:alert]).to include('メッセージが入力されていません')
    end
  end
end
