require 'Faker'

10.times do
  User.create(
    email: Faker::Internet.email, 
    password_digest: Faker::Lorem.word 
  )
end

20.times do
  Survey.create(title: Faker::Company.bs, user_id: rand(1..10))
end

50.times do
  Question.create(question: Faker::Lorem.sentence(3), survey_id: rand(1..20))
end

150.times do 
  Choice.create(choice: Faker::Lorem.word, question_id: rand(1..50))
end

