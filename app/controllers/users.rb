get '/user/profile' do
  @authored_surveys = current_user.authored_surveys
  @taken_surveys = current_user.taken_surveys
  @email = current_user.email

  erb :profile
end
