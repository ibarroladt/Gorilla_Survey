
get '/survey/:id/create' do
  @survey = Survey.find(params[:id])

  erb :create_survey
end

get '/survey/:id' do
  @survey = Survey.find(params[:id])

  erb :survey
end

get '/survey/take/:secret_key' do
  @survey = Survey.where(secret_key: params[:secret_key])
  erb :take_survey
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
  @survey = Survey.find(params[:survey_id].to_i)
  @participation = current_user.participations.where(survey_id: @survey.id).first
  @responses = params[:response]

  @responses.each do |question_id, choice_id|
    Response.create(choice_id: choice_id, participation_id: @participation.id)
  end
end

