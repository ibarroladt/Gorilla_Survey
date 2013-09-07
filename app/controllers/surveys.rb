
get '/survey/:id/create' do
  @survey = Survey.find(params[:id])

  erb :create_survey
end

get '/survey/:id' do
  @survey = Survey.find(params[:id])

  erb :survey
end

get '/survey/:id/user' do
  @survey = Survey.find(params[:id])
  
  erb :survey_user
end
# POSTS =================================

post '/survey/create' do
  title = params[:title]
  survey = Survey.create(title: title)
  current_user.surveys << survey
  redirect "/survey/#{survey.id}/create"
end
