class CareerResult < ActiveRecord::Base
  attr_accessible :popularity, :term

  def self.terms_for(pref)
	  	suggestions = where("term like ?", "#{pref}_%")
	  	suggestions.order("popularity desc").limit(10).pluck(:term)
  end

  def self.index_careers
  	SpeakerProfile.find_each do |profile|
  		index_term(profile.career)
  		profile.career.split.each{|c| index_term(c)}
  	end
  end

  def self.index_term(t)
  	where(term: t.downcase).first_or_initialize.tap do |suggestion|
  		suggestion.increment! :popularity
  	end
  end
end
