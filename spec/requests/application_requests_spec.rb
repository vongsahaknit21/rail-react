require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  let(:user) {FactoryBot.create :user}
  let(:access_token) {user.generate_auth}
  describe "#current_user" do
    it "should return user if current_access_tokens exist" do
      allow(controller).to receive(:auth_header).and_return("Baser " + access_token[:token])
      expect(controller.current_user.id).to eq user.id
    end

    it "should return user if current_access_tokens not exist" do
      allow(controller).to receive(:auth_header).and_return(nil)
      expect(controller.current_user).to eq nil
    end
  end

  describe "#logged_in?" do
    let(:user) {FactoryBot.create :user}
    it "should return true if current_user exist" do
      allow(controller).to receive(:current_user).and_return(user)
      expect(controller.logged_in?).to eq true
    end

    it "should return false if current_user not exist" do
      allow(controller).to receive(:current_user).and_return(nil)
      expect(controller.logged_in?).to eq false
    end
  end
end
