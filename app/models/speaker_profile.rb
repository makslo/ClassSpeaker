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
    p = %w{school availability}
    location = query[:location] if !query[:location].blank?
    career = query[:career] if !query[:career].blank?
    h = p.collect{|a| [a,query[a.to_sym].to_i]}
    result = []
    if career && location
      profile = where("career ilike ? AND location ilike ?", "%#{career}%", "%#{location}%")
    elsif location
      profile = where("location ilike ?", "%#{location}%")
    elsif career
      profile = where("career ilike ?", "%#{career}%")
    else
      profile = all
    end
    if h[0][1] != 0
      if h[0][1]==1
        profile = profile.map{|a| a if a.elementary}
      elsif h[0][1]==2
        profile = profile.map{|a| a if a.middle}
      elsif h[0][1]==3
        profile = profile.map{|a| a if a.high}
      elsif h[0][1]==4
        profile = profile.map{|a| a if a.college}
      end
      profile.delete(nil)
    end
    if h[1][1] != 0
      if h[1][1] == 1
        profile = profile.map{|a| a if a.in_person}
      elsif h[1][1] == 2
        profile = profile.map{|a| a if a.skype}
      elsif h[1][1] == 3
        profile = profile.map{|a| a if a.in_person && a.skype}
      end
      profile.delete(nil)
    end
    #search = result.empty? ? all : result.sum
    #clean = []
    #speaker = []
    #if !result.empty?
    #  search.each do |s|
    #    if !s.user.nil? && !speaker.include?(s.user_id)
    #      clean << s 
    #      speaker << s.user_id
    #    end
    #  end
    #end
    #clean

    #profile <<profile[0]
  
    profile
  end

  def self.remove_old
    all.each do |a|
      a.delete if a.user.nil?
    end
  end

  def get_locations
    loc = []
  	SpeakerProfile.all.each do |a|
      loc << a.location if !a.location.blank? && !loc.include?(a.location)
    end
    loc
  end
end
