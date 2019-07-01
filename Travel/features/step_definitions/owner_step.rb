Capybara.current_driver = :webkit

Given("A registered owner as {string},{string}") do |email, password|
    User.create(email: email, password: password, password_confirmation: password)
    visit new_user_session_path
    fill_in 'user_email', :with => email
    fill_in 'user_password', :with => password
    click_button 'Log in'
end

When("The owner {string} has a place") do |email|
    @owner = User.find_by_email(email)
    @place = @owner.property.build(name: "Place1", street: "Via Prova", address: 1, city: "Rome")
    @place.save!
end

When("The owner go to the place+id page") do
    @place = Place.first
    @id = @place.id
    visit "/places/" + @id.to_s
end

Then("The owner should see {string}") do |string|
    expect(page).to have_content(string)
end

Then("The owner click on {string} link") do |link|
    click_link link
end
  
  
  

  
  
  
  
  