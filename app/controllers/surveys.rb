
require 'json'

get '/survey/:id/create' do
  @survey = Survey.find(params[:id])

  erb :create_survey
end

get '/survey/:id/edit' do
	@survey = Survey.find(params[:id])

	erb :edit_survey
end

get '/survey/:id/user' do
  @survey = Survey.find(params[:id])
  
  erb :survey_user
end


get '/survey/take/:secret_key' do
  @survey = Survey.where(secret_key: params[:secret_key]).first
  erb :take_survey

end

get '/survey/:id/secret_key' do
  @survey = Survey.find(params[:id])
  erb :secret_key
end

get '/survey/:id/results' do
  @survey = Survey.find(params[:id])
  
  @participants = Participation.where(survey_id: params[:id]).count
  @completed_count = Participation.where(survey_id: params[:id], completion: true).count
  @questions = @survey.questions

  #question => {labels => [a,b,c],results => [r1,r2,r3] }
  # erb :results
  erb :results
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
  current_user.authored_surveys << survey
  redirect "/survey/#{survey.id}/create"
end

post '/survey/submit' do
  survey = Survey.find(params[:survey_id])
  responses = params[:response]
  

  if current_user
    participation = current_user.participations.create(survey_id: survey.id, completion: survey.complete?(responses))
    
    responses.each do |question_id, choice_id|
      Response.create(choice_id: choice_id, participation_id: participation.id)
    end
  else 
    participation = Participation.create(survey_id: survey.id, completion: survey.complete?(responses))
    responses.each do |question_id, choice_id|
      Response.create(choice_id: choice_id)
    end
  end

  erb :thank_you
end

post '/survey/:id/delete' do
  @survey = Survey.find(params[:id])
  @survey.destroy
  @authored_surveys = current_user.authored_surveys
  @taken_surveys = current_user.taken_surveys
  @email = current_user.email 
  content_type :json
  {redirect: "/user/profile"}.to_json
end


