require 'rails_helper'

describe Message do
  describe '#create' do

    let(:user)  { create(:user) }
    let(:group) { create(:group) }

    it "is valid with a content, user_id, group_id && pass the foreign_key constraint" do
      message = create(:message, user_id: user.id, group_id: group.id)
      expect(message).to be_valid
    end

    it "is invalid when content is nil" do
      message = build(:message, content: '')
      message.valid?
      expect(message.errors[:content]).to include("を入力してください。")
    end

    it "is invalid when user_id is nil" do
      message = build(:message, user_id: '')
      message.valid?
      expect(message.errors[:user_id]).to include("を入力してください。")
    end

    it "is invalid when group_id is nil" do
      message = build(:message, group_id: '')
      message.valid?
      expect(message.errors[:group_id]).to include("を入力してください。")
    end

  end
end
