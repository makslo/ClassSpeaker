class SpeakerProfile < ActiveRecord::Base
  attr_accessible :bio, :career, :college, :elementary, :high, :in_person, :location, :middle, :skype, :user_id, :years
  
  validates :location, :presence => true

  belongs_to :user
  CAREERS = %w{ Finance Accounting Singer}

  def get_careers
  	CAREERS
  end

  def self.find_speakers(user_career, user_location, user_school)
  	where(career: user_career)
  end

  def get_locations
  	l = SpeakerProfile.all.map{|a| a.location if !a.location.blank?}
  end
end
