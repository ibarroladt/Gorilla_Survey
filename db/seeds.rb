require 'Faker'

javier = User.create(email: "javier@dev.com", password: "1")
sean = User.create(email: "sean@dev.com", password: "1")
brian = User.create(email: "brian@dev.com", password: "1")
user = User.create(email: "user@dev.com", password: "1")

dev_users = [javier, sean, brian, user]


15.times do
  dev_users.sample.authored_surveys << Survey.create(title: Faker::Company.bs, secret_key: Survey.make_secret_key)
end

50.times do
  dev_users.sample.authored_surveys.sample.questions << Question.create(question: Faker::Lorem.sentence(3))
end

150.times do 
  question = dev_users.sample.authored_surveys.sample.questions.sample
  if question
   question.choices << Choice.create(choice: Faker::Lorem.word)
  end
end


20.times do
  User.create(
    email: Faker::Internet.email, 
    password: Faker::Lorem.word 
  )
end

# 5.times do
#   Survey.create(title: Faker::Company.bs, user_id: rand(1..10),secret_key: Survey.make_secret_key)
# end

# 50.times do
#   Question.create(question: Faker::Lorem.sentence(3), survey_id: rand(1..20))
# end

# 150.times do 
#   Choice.create(choice: Faker::Lorem.word, question_id: rand(1..50))
# end

50.times do
  Participation.create(user_id: rand(1..10), survey_id: rand(1..20), completion: [true, false].sample )
end

50.times do
  Participation.create(user_id: nil, survey_id: rand(1..20), completion: [true, false].sample )
end

100.times do
  Response.create(participation_id: rand(1..100), choice_id: rand(1..20))
end







