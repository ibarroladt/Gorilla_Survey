
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

get '/survey/:id/user' do
  @survey = Survey.find(params[:id])
  
  erb :survey_user
end

get '/survey/:id/results' do
  @survey = Survey.find(params[:id])
  @total_takers = Participation.where(survey_id: params[:id]).count
  @total_completed = Participation.where(survey_id: params[:id], completion: true).count / @total_takers
  erb :results
end


get '/survey/take/:secret_key' do
  @survey = Survey.where(secret_key: params[:secret_key]).first
  erb :take_survey

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

post '/survey/submit' do
  survey = Survey.find(params[:survey_id].to_i)
  responses = params[:response]
  
  participation = current_user.participations.create(survey_id: survey.id, completion: survey.complete?(responses))

  if current_user
    responses.each do |question_id, choice_id|
      Response.create(choice_id: choice_id, participation_id: participation.id)
    end
  else 
    responses.each do |question_id, choice_id|
      Response.create(choice_id: choice_id)
    end
  end

  erb :thank_you
end


