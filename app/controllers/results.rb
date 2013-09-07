get '/survey/:id/results' do
  @survey = Survey.find(params[:id])
  @participants = Participation.where(survey_id: params[:id]).count
  @completed_count = Participation.where(survey_id: params[:id], completion: true).count

  erb :results
end
