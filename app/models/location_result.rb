class LocationResult < ActiveRecord::Base
  attr_accessible :popularity, :term

  def self.terms_for(pref)
	  	suggestions = where("term like ?", "#{pref}_%")
	  	suggestions.order("popularity desc").limit(10).pluck(:term)
  end

  def self.index_locations
    delete_all
  	User.find_each do |profile|
  		index_term(profile.address) if profile.address
  	end
  end

  def self.index_term(t)
  	where(term: t.downcase).first_or_initialize.tap do |suggestion|
  		suggestion.increment! :popularity
  	end
  end
end
