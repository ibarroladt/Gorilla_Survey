require 'json'

get '/survey/:survey_id/question/:question_id/create' do
  @question = Question.find(params[:question_id])
  erb :create_question
end

get '/survey/:survey_id/question/:question_id/edit' do
  @question = Question.find(params[:question_id])
  erb :edit_question
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

post '/choices/update' do
  p params
  params[:update].each do |choice_id, choice|
    @choice = Choice.find(choice_id)
    @choice.update_attributes(choice: choice)
  end
  redirect "/survey/#{@choice.question.survey.id}/question/#{@choice.question.id}/edit"
end

post '/choice/:id/delete' do 
  @choice = Choice.find(params[:id])
  @choice.destroy
  @question = @choice.question 
  erb :edit_question, layout: false
end

post '/survey/:survey_id/question/:question_id/delete' do
  @question = Question.find(params[:question_id])
  @survey = @question.survey
  @question.destroy
  erb :edit_survey, layout: false
end
