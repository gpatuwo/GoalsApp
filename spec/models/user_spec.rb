# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validates user credentials" do
    before(:each) do
      User.create!(name: "Robert", password: "good_password")
    end
    # can also do a subject
    it { should validate_presence_of(:name)}
    it { should validate_uniqueness_of(:name)}
    it { should validate_presence_of(:password_digest)}
    it { should validate_length_of(:password).is_at_least(6)}
    it { should have_many(:goals)}
  end

  describe "session token" do

    it "assigns session token upon initialization" do
      user = User.create!(name: "Robert", password: "good_password")
      expect(user.session_token).not_to be_nil
    end

    it "doesn't assign session token with incorrect credentials" do
      user = User.new(name: "Grace")
      user.valid?
      expect(user.errors[:password_digest]).to include("can't be blank")
    end
  end

  describe "password digest" do

    it "encrypts the password" do
      expect(BCrypt::Password).to receive(:create)
      User.new(name: "Robert", password: "good_password")
    end

    it "saves pasword digest to database upon initialization" do
      user = User.create!(name: "Robert", password: "good_password")
      expect(user.password_digest).not_to be_nil
    end

    it "does not save password to database" do
      user = User.create!(name: "Robert", password: "good_password")
      expect(user.password).not_to be("good_password")
    end

  end


end
