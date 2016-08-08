require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_path
    expect(page).to have_content "New User"
    expect(page).to have_button "Sign Up"
  end

  feature "signing up a user" do
    before(:each) do
      make_robert_user
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "Robert"
    end

    scenario "shows goals index" do
      expect(page).to have_content "Goals"
    end

  end

end

feature "logging in" do
  before(:each) do
    make_robert_user
  end

  scenario "shows username on the homepage after login" do
    sign_in("Robert")
    expect(page).to have_content "Robert"
  end

end

feature "logging out" do
  scenario "begins with a logged out state" do
    visit goals_path
    expect(page).to have_content "Log In"
    expect(page).not_to have_content "Robert"
  end

  scenario "doesn't show username on the homepage after logout" do
    make_robert_user
    click_on "Log Out"
    expect(page).not_to have_content "Robert"
  end

end
