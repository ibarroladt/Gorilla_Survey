class Survey < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  
  has_many :participations
  has_many :users, through: :participations
  has_many :responses, through: :participations

  has_many :questions
end
