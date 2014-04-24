require 'spec_helper'

describe User do
  subject(:user) { FactoryGirl.create(:user) }

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }

  it { should validate_presence_of(:password_hash) }
  it { should_not respond_to(:password) }

  it { should have_many(:shortlinks) }
  it { should have_many(:target_urls) }

  it { should validate_presence_of(:session_token) }
  it { should respond_to(:reset_session_token!) }
  

  describe "#reset_session_token" do
    it "should change the user's session token" do
      old_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).not_to equal(old_token)
    end

    it "should save the user" do
      last_update = user.updated_at
      user.reset_session_token!
      expect(user.updated_at).not_to equal(last_update)
    end
  end

  describe "#password=" do
    it "should change the stored password hash" do
      old_password_hash = user.password_hash
      user.password="newpassword"
      expect(user.password_hash).not_to equal(old_password_hash)
    end
  end

  describe "User.find_by_credentials" do
    it "looks up the user by username/password combo" do
      new_user = User.create(username: "testuser", password: "password")
      found_user = User.find_by_credentials( username: "testuser", password: "password" )
      expect(found_user.id).to equal(new_user.id)
    end

    it "returns nil when given wrong password" do
      new_user = User.create(username: "testuser", password: "password")
      found_user = User.find_by_credentials( username: "testuser", password: "passwordpassword" )
      expect(found_user).to be_nil
    end

    it "returns nil when given a nonexistent username" do
      new_user = User.create(username: "testuser", password: "password")
      found_user = User.find_by_credentials( username: "nobody", password: "asdfasdfasdf" )
      expect(found_user).to be_nil
    end

    it "returns nil when both username and password are wrong" do
      new_user = User.create(username: "testuser", password:"password")
      found_user = User.find_by_credentials( username: "wrongname", password: "wrongpassword")
      expect(found_user).to be_nil
    end
  end
end
