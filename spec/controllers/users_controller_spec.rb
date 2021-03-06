require 'spec_helper'

describe UsersController do
  include Warden::Test::Helpers

  before(:each) do
    Warden.test_mode!
  end

  after(:each) do
    Warden.test_reset!
  end

  def valid_attributes
    attributes_for(:user)
  end

  describe "POST create as admin user" do
    before(:each) do
      @user_admin = create(:user, :admin)
      sign_in(@user_admin)
    end

    describe "with valid params" do
      it "creates a new user" do
        expect {
          page.driver.post users_path, :user => valid_attributes
        }.to change(User, :count).by(1)
      end
    end
  end

end
