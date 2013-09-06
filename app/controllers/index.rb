get '/' do
  # Look in app/views/index.erb
  erb :index
end


#POSTS====================================


post '/login' do
  email = params[:email]
  password = params[:password]

  @user = User.authenticate(email,password) # check name of method 

  if @user
    session[:user_id] = @user.id
    redirect "/user/profile"
  else
    @error = "ERROR: User validation failed, check your password or log in"
    erb :index
  end
end

post '/register' do
  begin
    user = User.create(params[:register])
    session[:user_id] = user.id
    redirect "/user/profile"
   rescue
    @error = "ERROR: User creation failed, please try again"
    erb :index
  end
end
