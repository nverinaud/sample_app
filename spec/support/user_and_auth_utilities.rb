
def fill_in_signup_form_with_valid_information
  fill_in "Name",         with: "Example User"
  fill_in "Email",        with: "user@example.com"
  fill_in "Password",     with: "foobar"
  fill_in "Confirmation", with: "foobar"
end

def fill_in_signin_form_with_user(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
end

RSpec::Matchers.define :have_saved_user do |user|
  match do |page|
    page.should have_title(user.name)
    page.should flash_success('Welcome')
    page.should have_link('Sign out')
  end
end