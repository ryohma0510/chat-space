require 'rails_helper'

describe Message do
  describe '#create' do

    it "is valid with a content" do
      message = build(:message)
      expect(message).to be_valid
    end

    it "is invalid when content is nil" do
      message = build(:message, content: '')
      message.valid?
      expect(message.errors[:content]).to include("を入力してください。")
    end
  end
end
