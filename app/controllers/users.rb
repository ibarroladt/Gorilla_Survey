get '/user/:id' do
  @surveys = ["Survey 1", "Survey 2", "Survey 3"] #current_user.surveys
  @email = "Bob@email.com" #current_user.email

  erb :profile
end
