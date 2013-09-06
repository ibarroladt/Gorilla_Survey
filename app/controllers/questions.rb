get '/survey/:survey_id/question/:question_id/create' do
  @question = Question.find(params[:question_id])
  erb :create_question
end


#POST ============================================================

post '/survey/:id/question/create' do
  question = params[:question]
  question = Question.create(question: question)
  survey = Survey.find(params[:id])
  survey.questions << question 
  redirect "/survey/#{survey.id}/question/#{question.id}/create"
end

post '/survey/:survey_id/question/:question_id/choice/create' do
  choice = params[:choice]
  choice = Choice.create(choice: choice)
  question = Question.find(params[:question_id])
  question.choices << choice 
  redirect "/survey/#{question.survey.id}/question/#{question.id}/create"
end
