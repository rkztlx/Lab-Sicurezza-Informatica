Given("A registered admin as {string}, {string}") do |email, password|
    @admin = User.create(email: email, password: password, password_confirmation: password)
    @admin.roles = @admin.roles << :admin
    @admin.save!
    visit new_user_session_path
    fill_in 'user_email', :with => email
    fill_in 'user_password', :with => password
    click_button 'Log in'
end
  
Given("another user exists") do
    User.create(email: "another@user.it", password: "12345678", password_confirmation: "12345678")
end
  
  
Given("The admin go to the user profile") do
    visit "/users/" + User.last.id.to_s
end
  
Then("The admin should see {string}") do |string|
    expect(page).to have_content(string)
end
  
Given("The admin click to the {string} link") do |link|
    click_link link
end
  
Then("the user is banned") do
    User.last.is? :banned
end
  
Given("another banned user exists") do
    @user = User.create(email: "another@user.it", password: "12345678", password_confirmation: "12345678")
    @user.roles = @user.roles << :banned
    @user.save!
end
  
Then("the user is not banned") do
    !User.last.is? :banned
end

  
Given("another moderator not banned and not admin exists") do
    @moderator = User.create(email: "another@user.it", password: "12345678", password_confirmation: "12345678")
    @moderator.roles = @moderator.roles << :moderator
    @moderator.save!
end
  