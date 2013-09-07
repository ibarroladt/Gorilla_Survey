class Survey < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  
  has_many :participations
  has_many :users, through: :participations
  has_many :responses, through: :participations

  has_many :questions
  
  validates_uniqueness_of :secret_key

  def self.make_secret_key
    letters_numbers = ("A".."Z").to_a + ("a".."z").to_a + ("1".."9").to_a
    key = ''
    16.times { key << letters_numbers.sample }
    key
  end

  def complete?(response_hash)
    self.questions.length == response_hash.length
  end

end
