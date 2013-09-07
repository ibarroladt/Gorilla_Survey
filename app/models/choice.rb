class Choice < ActiveRecord::Base
  has_many :responses
  belongs_to :question 

  def num_responses
    self.responses.count
  end

end
