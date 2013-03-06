class SpeakerProfile < ActiveRecord::Base
  attr_accessible :bio, :career, :college, :elementary, :high, :in_person, :location, :middle, :skype, :user_id, :years
  
  validates :location, :presence => true
  validates :bio, :presence => true
  validates :career, :presence => true
  validates :years, :presence => true

  belongs_to :user
  CAREERS = %w{ Finance Accounting Singer}

  def get_careers
  	CAREERS
  end

  def self.find_speakers(query)
    p = %w{school years availability}
    location = query[:location] if !query[:location].blank?
    career = query[:career] if !query[:career].blank?
    h = p.collect{|a| [a,query[a.to_sym].to_i]}
    result = []
    if h[0][1] != 0
      if h[0][1]==1
      result << where(elementary: true)
      elsif h[0][1]==2
      result << where(middle: true)
      elsif h[0][1]==3
      result << where(high: true)
      elsif h[0][1]==4
      result << where(college: true)
      end
    end
    if h[1][1] != 0
      result << where(:years=>h[1][1])
    end
    if h[2][1] != 0
      if h[2][1] == 1
      result << where(in_person: true)
      elsif h[2][1] == 2
      result << where(skype: true)
      end
    end
    if career
      result << where("career like ?", "%#{career}%")
    end
    if location
      result << where("location like ?", "%#{location}%")
    end
    search = result.empty? ? all : result.sum
    clean = []
    speaker = []
    search.each do |s|
      if !s.user.nil? && !speaker.include?(s.user_id)
        clean << s 
        speaker << s.user_id
      end
    end
    clean
  end

  def get_locations
    loc = []
  	SpeakerProfile.all.each do |a|
      loc << a.location if !a.location.blank? && !loc.include?(a.location)
    end
    loc
  end
end
