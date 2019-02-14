require 'rails_helper'

describe "As a user" do
  before(:each) do
    @user = create(:user)
    stub_login(@user)
  end

  describe "When I visit my dashbaord ('/dashboard')" do
    it "I should see my spotify username and profile image" do
      visit dashboard_path

      within '#basic-info' do
        expect(page).to have_content("Welcome, #{@user.username}")
        expect(page).to have_css("img[src='#{@user.image_url}']")
      end
    end
  end
end
