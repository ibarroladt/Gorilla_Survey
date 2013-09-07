class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :choices
  has_many :responses, through: :choices
  
  def total_responses
    choices = Choice.where(question_id: self.id) 
    total = 0
    choices.each do |choice|
      total += choice.responses.count
    end
    total
  end

end
