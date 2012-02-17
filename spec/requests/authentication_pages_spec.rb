require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "sign in Page" do
    before { visit signin_path }

    it { should have_title('Sign in') }
    it { should have_h1('Sign in') }
  end


  describe "sign in"  do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should flash_error('Invalid') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not flash_error }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in_signin_form_with_user(user)
        click_button "Sign in"
      end

      it { should have_title(user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by sign out" do
        before { click_link "Sign out" }
        it { should have_link('Sign in', href: signin_path) }
      end
    end
  end

end
