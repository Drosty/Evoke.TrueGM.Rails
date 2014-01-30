require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe Admin::LeaguesController do

  # This should return the minimal set of attributes required to create a valid
  # Admin::League. As you add validations to Admin::League, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Admin::LeaguesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all admin_leagues as @admin_leagues" do
      league = Admin::League.create! valid_attributes
      get :index, {}, valid_session
      assigns(:admin_leagues).should eq([league])
    end
  end

  describe "GET show" do
    it "assigns the requested admin_league as @admin_league" do
      league = Admin::League.create! valid_attributes
      get :show, {:id => league.to_param}, valid_session
      assigns(:admin_league).should eq(league)
    end
  end

  describe "GET new" do
    it "assigns a new admin_league as @admin_league" do
      get :new, {}, valid_session
      assigns(:admin_league).should be_a_new(Admin::League)
    end
  end

  describe "GET edit" do
    it "assigns the requested admin_league as @admin_league" do
      league = Admin::League.create! valid_attributes
      get :edit, {:id => league.to_param}, valid_session
      assigns(:admin_league).should eq(league)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Admin::League" do
        expect {
          post :create, {:admin_league => valid_attributes}, valid_session
        }.to change(Admin::League, :count).by(1)
      end

      it "assigns a newly created admin_league as @admin_league" do
        post :create, {:admin_league => valid_attributes}, valid_session
        assigns(:admin_league).should be_a(Admin::League)
        assigns(:admin_league).should be_persisted
      end

      it "redirects to the created admin_league" do
        post :create, {:admin_league => valid_attributes}, valid_session
        response.should redirect_to(Admin::League.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved admin_league as @admin_league" do
        # Trigger the behavior that occurs when invalid params are submitted
        Admin::League.any_instance.stub(:save).and_return(false)
        post :create, {:admin_league => {  }}, valid_session
        assigns(:admin_league).should be_a_new(Admin::League)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Admin::League.any_instance.stub(:save).and_return(false)
        post :create, {:admin_league => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested admin_league" do
        league = Admin::League.create! valid_attributes
        # Assuming there are no other admin_leagues in the database, this
        # specifies that the Admin::League created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Admin::League.any_instance.should_receive(:update).with({ "these" => "params" })
        put :update, {:id => league.to_param, :admin_league => { "these" => "params" }}, valid_session
      end

      it "assigns the requested admin_league as @admin_league" do
        league = Admin::League.create! valid_attributes
        put :update, {:id => league.to_param, :admin_league => valid_attributes}, valid_session
        assigns(:admin_league).should eq(league)
      end

      it "redirects to the admin_league" do
        league = Admin::League.create! valid_attributes
        put :update, {:id => league.to_param, :admin_league => valid_attributes}, valid_session
        response.should redirect_to(league)
      end
    end

    describe "with invalid params" do
      it "assigns the admin_league as @admin_league" do
        league = Admin::League.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Admin::League.any_instance.stub(:save).and_return(false)
        put :update, {:id => league.to_param, :admin_league => {  }}, valid_session
        assigns(:admin_league).should eq(league)
      end

      it "re-renders the 'edit' template" do
        league = Admin::League.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Admin::League.any_instance.stub(:save).and_return(false)
        put :update, {:id => league.to_param, :admin_league => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested admin_league" do
      league = Admin::League.create! valid_attributes
      expect {
        delete :destroy, {:id => league.to_param}, valid_session
      }.to change(Admin::League, :count).by(-1)
    end

    it "redirects to the admin_leagues list" do
      league = Admin::League.create! valid_attributes
      delete :destroy, {:id => league.to_param}, valid_session
      response.should redirect_to(admin_leagues_url)
    end
  end

end
