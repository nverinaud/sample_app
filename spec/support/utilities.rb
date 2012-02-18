def full_title(page_title)
  base_title = "Ruby on Rails Tutorial Sample App"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end


def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end


# <title>
RSpec::Matchers.define :have_title do |title|
  match do |page|
    page.should have_selector('title', text: title)
  end
end


# <h1>
RSpec::Matchers.define :have_h1 do |title|
  match do |page|
    page.should have_selector('h1', text: title)
  end
end

# Error flash
RSpec::Matchers.define :flash_error do |error_msg|
  match do |page|
    if !error_msg.nil?
      page.should have_selector('div.flash.error', text: error_msg)
    else
      page.should have_selector('div.flash.error')
    end
  end
end


# Success flash
RSpec::Matchers.define :flash_success do |success_msg|
  match do |page|
    if !success_msg.nil?
      page.should have_selector('div.flash.success', text: success_msg)
    else
      page.should have_selector('div.flash.success')
    end
  end
end