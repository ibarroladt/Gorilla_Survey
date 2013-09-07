get '/survey/:survey_id/question/:question_id/create' do
  @question = Question.find(params[:question_id])
  erb :create_question
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

get '/choice/:id/delete' do 
  @choice = Choice.find(params[:id])
  @choice.destroy
  @question = @choice.question 
  redirect "/survey/#{@question.survey.id}/question/#{@question.id}/edit"
end

#POST ============================================================

post '/survey/:id/question/create' do
  question = params[:question]
  question = Question.create(question: question)
  survey = Survey.find(params[:id])
  survey.questions << question 
  redirect "/survey/#{survey.id}/question/#{question.id}/create"
end

post '/survey/:id/question/add' do
  question = params[:question]
  question = Question.create(question: question)
  survey = Survey.find(params[:id])
  survey.questions << question 
  redirect "/survey/#{survey.id}/edit"
end

post '/survey/:survey_id/question/:question_id/choice/create' do
  choice = params[:choice]
  choice = Choice.create(choice: choice)
  question = Question.find(params[:question_id])
  question.choices << choice 
  redirect "/survey/#{question.survey.id}/question/#{question.id}/create"
end

post '/survey/:survey_id/question/:question_id/update' do
  @question = Question.find(params[:question_id])
  @question.update_attributes(question: params[:question])
  redirect "/survey/#{params[:survey_id]}/edit"
end

post '/survey/:survey_id/question/:question_id/choice/add' do
  choice = params[:choice]
  choice = Choice.create(choice: choice)
  question = Question.find(params[:question_id])
  question.choices << choice 
  redirect "/survey/#{question.survey.id}/question/#{question.id}/edit"
end