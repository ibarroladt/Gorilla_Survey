
get '/survey/:id/create' do
  @survey = Survey.find(params[:id])

  erb :create_survey
end

get '/survey/:id' do
  @survey = Survey.find(params[:id])

  erb :survey
end


# POSTS =================================

post '/survey/create' do
  title = params[:title]
  survey = Survey.create(title: title)
  key = Survey.make_secret_key
  survey.update_attributes(:secret_key => key)
  current_user.surveys << survey
  redirect "/survey/#{survey.id}/create"
end
