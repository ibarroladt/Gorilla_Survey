
get '/survey/:id/create' do
  @survey = Survey.find(params[:id])

  erb :create_survey
end

get '/survey/:id/delete' do
  @survey = Survey.find(params[:id])
  @survey.destroy 
  redirect '/user/profile'
end

get '/survey/:id/edit' do
	@survey = Survey.find(params[:id])

	erb :edit_survey
end

get '/survey/:survey_id/question/:question_id/delete' do
	@question = Question.find(params[:question_id])
	@question.destroy
	redirect "/survey/#{params[:survey_id]}/edit"
end

get '/survey/:survey_id/question/:question_id/edit' do
	@question = Question.find(params[:question_id])
	erb :edit_question
end

get '/survey/:id' do
  @survey = Survey.find(params[:id])

  erb :survey
end

# POSTS ====================================================

post '/survey/create' do
  title = params[:title]
  survey = Survey.create(title: title)
  current_user.surveys << survey
  redirect "/survey/#{survey.id}/create"
end

post '/survey/:survey_id/question/:question_id/update' do
	@question = Question.find(params[:question_id])
	@question.update_attributes(question: params[:question])
	redirect "/survey/#{params[:survey_id]}/edit"
end
