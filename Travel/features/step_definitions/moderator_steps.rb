Given("A registered moderator as {string}, {string}") do |email, password|
    @moderator = User.create(email: email, password: password, password_confirmation: password)
    @moderator.roles = @moderator.roles << :moderator
    @moderator.save!
    visit new_user_session_path
    fill_in 'user_email', :with => email
    fill_in 'user_password', :with => password
    click_button 'Log in'
end
  
Given("Exists a place") do
    @place = Place.create(name: "Place1", street: "Via Prova", address: 1, city: "Rome")
    @place.save!
end
  
Given("The moderator go to the place+id page") do
    @place = Place.last
    @id = @place.id
    visit "/places/" + @id.to_s
end
  
Given("Exists a review on the place") do
    @place = Place.last
    @review = @place.reviews.build(rating: 3, comments: "Prova")
    @user = User.create(email: "another@live.it", password: "12345678", password_confirmation: "12345678")
    @user.reviews << @review
    @review.save!
end
  
Then("The moderator should see {string}") do |string|
    expect(page).to have_content(string)
end
  