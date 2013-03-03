class SpeakerProfile < ActiveRecord::Base
  attr_accessible :bio, :career, :college, :elementary, :high, :in_person, :location, :middle, :skype, :user_id, :years
  
  validates :location, :presence => true

  belongs_to :user
  CAREERS = %w{ Finance Accounting Singer}

  def get_careers
  	CAREERS
  end

  def self.find_speakers(query)
    p = %w{career school years location availability}
    location = query[:location] if query[:location]!="Any"
    h = p.collect{|a| [a,query[a.to_sym].to_i]}
    result = []
    if h[0][1] != 0
      result << where(:career=>CAREERS[h[0][1]-1])
    end
    if h[1][1] != 0
      if h[1][1]==1
      result << where(elementary: true)
      elsif h[1][1]==2
      result << where(middle: true)
      elsif h[1][1]==3
      result << where(high: true)
      elsif h[1][1]==4
      result << where(college: true)
      end
    end
    if h[2][1] != 0
      result << where(:years=>h[2][1])
    end
    if h[4][1] != 0
      if h[4][1] == 1
      result << where(in_person: true)
      elsif h[4][1] == 2
      result << where(skype: true)
      end
    end
    if location
      result << where(location: location)
    end
    search = result.empty? ? all : result.sum
  end

  def get_locations
  	l = SpeakerProfile.all.map{|a| a.location if !a.location.blank?}
  end
end
