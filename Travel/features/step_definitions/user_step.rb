Given("no user exists with an email of {string}") do |string|
    User.find_by_email(string).should be_nil
end

When("The user sign up as {string},{string},{string},{string},{string}") do |email, password, name, surname, nickname|
   User.create(email: email, password: password, name: name, surname: surname, nickname: nickname)
   click_button "Sign up"
end

When("The user create the place as {string},{string},{int},{string}") do |name,street,address,city|
   Place.create(name: name, street: street, address: address, city: city)
   find('input[name="Save Changes"]').click
end

Then("The user should be redirected to {string} page") do |page|
    expect(current_path).to eql page
end


Given("A registered user as {string}") do |email|
    User.find_by_email(email)
end

Given("An User is signed up and confirmed as {string},{string},{string},{string},{string}") do |email, password, name, surname, nickname|
    User.create(email: email, password: password, name: name, surname: surname, nickname: nickname)
end

When("An user go to the {string} page") do |page|
    visit page
end

When("The user sign in as {string},{string}") do |email, password|
    fill_in 'user_email', :with => email
    fill_in 'user_password', :with => password
    click_button 'Log in'
end

When("An user click the {string} button") do |button|
    click_button button
end

Then("An user should see the {string}") do |button|
    expect(page).to have_content("Log in")
end

When("An {string} go to the user+id page") do |email|
    @user = User.find_by_email(email)
    @id = @user.id
    visit "/users/"+@id.to_s
end
