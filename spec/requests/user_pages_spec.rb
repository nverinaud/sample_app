require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_title('Sign Up') }
    it { should have_h1('Sign Up') }
  end


  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_title(user.name) }
    it { should have_h1(user.name) }
  end


  describe "signup" do
    before { visit signup_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Sign up" }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before { fill_in_signup_form_with_valid_information }

      it "should create a user" do
        expect { click_button "Sign up" }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button "Sign up" }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_saved_user(user) }
      end
    end

    describe "error messages" do
      before { click_button "Sign up" }

      let(:error) { 'errors prohibited this user from being saved' }

      it { should have_title('Sign Up') }
      it { should have_content(error) }
    end
  end


  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_title("Edit user") }
      it { should have_h1("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      let(:error) { '1 error prohibited this user from being saved' }
      before { click_button "Update" }

      it { should have_content(error) }
    end

    describe "with valid information" do
      let(:user)      { FactoryGirl.create(:user) }
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",         with: new_name
        fill_in "Email",        with: new_email
        fill_in "Password",     with: user.password
        fill_in "Confirmation", with: user.password
        click_button "Update"
      end

      it { should have_title(new_name) }
      it { should flash_success }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
  
end