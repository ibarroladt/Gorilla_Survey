
get '/survey/:id/create' do
  @survey = Survey.find(params[:id])

  
  erb :create_survey
end



# POSTS =================================

post '/survey/create' do
  title = params[:title]
  survey = Survey.create(title: title)
  current_user.surveys << survey
  redirect "/survey/#{survey.id}/create"
end
