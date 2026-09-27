module SystemHelpers
  def sign_in_as(user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password123"
    click_button "Log in"
  end

  def sign_up_as(name:, email:, password: "password123")
    visit new_user_registration_path
    fill_in "Name", with: name
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password
    click_button "Sign up"
  end
end

RSpec.configure do |config|
  config.include SystemHelpers, type: :system
end
