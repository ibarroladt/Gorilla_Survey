class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  has_many :responses

  validates_uniqueness_of :user_id, :scope => :survey_id, :allow_nil => true
  
  # this is saying you canot use user_id more than once for a given survey_id
end
 
