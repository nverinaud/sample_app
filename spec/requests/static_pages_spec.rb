require 'spec_helper'

describe "Static pages" do

  subject { page }

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    page.should have_selector 'title', text: full_title('Home')
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign Up')
  end

  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(pageTitle)) }
  end

  describe "Home page" do
    before { visit root_path }

    let(:heading) { 'Sample App' }
    let(:pageTitle) { 'Home' }

    it_should_behave_like "all static pages"

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in(user)
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("tr##{item.id}", text: item.content)
        end
      end
    end
  end

  describe "Help page" do
    before { visit help_path }

    let(:heading) { 'Help' }
    let(:pageTitle) { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }

    let(:heading) { 'About' }
    let(:pageTitle) { 'About Us' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }

    let(:heading) { 'Contact' }
    let(:pageTitle) { 'Contact' }

    it_should_behave_like "all static pages"
  end

  describe "Sign Up page" do
    before { visit signup_path }

    let(:heading) { 'Sign Up' }
    let(:pageTitle) { 'Sign Up' }

    it_should_behave_like "all static pages"
  end
end