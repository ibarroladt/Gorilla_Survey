class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  has_many :responses

  validates_uniqueness_of :user_id, :scope => :survey_id
  
end
 
