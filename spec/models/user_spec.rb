require 'rails_helper'
describe User do
  describe '#create' do

    it "is valid with a name, email, password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without a name" do
     user = build(:user, name: "")
     user.valid?
     expect(user.errors[:name]).to include("を入力してください。")
    end

    it "is invalid without a email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください。")
    end

    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください。")
    end

    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません。")
    end

    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します。")
    end

    it "is invalid with a name >= 7 characters " do
      user = build(:user, name: "aaaaaaaa")
      user.valid?
      expect(user.errors[:name][0]).to include("は6文字以内で入力してください。")
    end

    it "is valid with a name <= 6 characters " do
      user = build(:user, name: "aaaaaa")
      expect(user).to be_valid
    end

    it "is invalid with a password that has <= 7 characters " do
      user = build(:user, password: "1234567", password_confirmation: "1234567")
      user.valid?
      expect(user.errors[:password][0]).to include("は8文字以上で入力してください。")
    end

  end
end
