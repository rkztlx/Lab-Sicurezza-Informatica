Given("no user exists with an email of {string}") do |string|
    User.find_by_email(string).should be_nil
end

When("The user sign up as {string},{string},{string},{string},{string}") do |email, password, name, surname, nickname|
   User.create(email: email, password: password, name: name, surname: surname, nickname: nickname)
   click_button "Sign up"
end

When("The user create the place as {string},{string},{int},{string}") do |name,street,address,city|
   fill_in 'place_name', :with => name
   fill_in 'place_street', :with => street
   fill_in 'place_address', :with => address
   fill_in 'place_city', :with => city
   find('input[name="commit"]').click
end

Then("The user should be redirected to {string} page") do |page|
    expect(current_path).to eql page
end


Given("A registered user as {string},{string}") do |email, password|
    User.create(email: email, password: password, password_confirmation: password)
    visit new_user_session_path
    fill_in 'user_email', :with => email
    fill_in 'user_password', :with => password
    click_button 'Log in'
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

Then("An user should see the {string}") do |element|
    expect(page).to have_content(element)
end

When("An user click the {string}") do |element|
    find("#logo").click()
end



When("An {string} go to the user+id page") do |email|
    @user = User.find_by_email(email)
    @id = @user.id
    visit "/users/"+@id.to_s
end

Given("{string},{string},{int},{string} place exist") do |name, street, address, city|
    @place = Place.create(name: name, street: street, address: address, city: city)
    @place.save!
end

When("An user search for {string} place") do |place|
   find("#ser").set(place)
   find("#searchsub").click()
end

