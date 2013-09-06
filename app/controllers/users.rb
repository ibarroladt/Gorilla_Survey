get '/user/profile' do
  @surveys = current_user.surveys
  @email = current_user.email

  erb :profile
end
