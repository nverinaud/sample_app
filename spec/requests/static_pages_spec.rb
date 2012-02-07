require 'spec_helper'

describe "Static pages" do

	let(:baseTitle) { "Ruby on Rails Tutorial Sample App" }

  describe "Home page" do

    it "should have an h1 containing 'Sample App'" do
      visit '/static_pages/home'
      page.should have_selector('h1', text: 'Sample App')
    end

    it "should have the title 'Home'" do
    	visit '/static_pages/home'
    	page.should have_selector('title', 
    						text: "#{baseTitle} | Home")
    end

  end

  describe "Help page" do

    it "should have an h1 containing 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', text: 'Help')
    end

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title',
                        	text: "#{baseTitle} | Help")
    end

  end

  describe "About page" do

    it "should have an h1 containing 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('h1', text: 'About Us')
    end

    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('title',
                    	text: "#{baseTitle} | About Us")
    end

  end

  describe "Contact page" do

    it "should have an h1 containing 'Contact Us'" do
      visit '/static_pages/contact'
      page.should have_selector('h1', text: 'Contact Us')
    end

    it "should have the title 'Contact'" do
      visit '/static_pages/contact'
      page.should have_selector('title',
                    	text: "#{baseTitle} | Contact")
    end

  end

end