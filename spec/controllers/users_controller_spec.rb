require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "creates user" do

    it "has a new view form" do
      get :new, user: {}
      expect(response).to render_template("new")
    end

    context "with invalid params" do
      it "validates credentials, renders new form, flashes errors" do
        post :create, user:{name: "Grace", password: "bad"}
        expect(response).to render_template("new")
        # test to see if spec would fail if you didn't include render :new in create method
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "validates credentials, redirects" do
        post :create, user:{name: "Grace", password: "good_pass"}
        expect(response).to redirect_to(goals_url)
      end

      it "logs in user" do
        post :create, user:{name: "Grace", password: "good_pass"}
        user = User.find_by_name("Grace")
        expect(user.session_token).to eq(session[:session_token])
      end
    end

  end


end
