class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:linkedin]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :speaker, :speaker_profile_attributes,
                  :provider, :uid, :last_name, :first_name, :bio, :industry, :location, :skills, :speak_about,
                  :elementary, :middle, :high, :college, :new_user, :years, :latitude, :longitude, :address, :teacher
  # attr_accessible :title, :body
  validates :first_name, :last_name, :presence=>true
  has_one :speaker_profile, :dependent => :delete
  accepts_nested_attributes_for :speaker_profile, allow_destroy: true

  	geocoded_by :location
	reverse_geocoded_by :latitude, :longitude do |obj,results|
		if geo = results.first
			obj.address    = geo.city+", "+geo.state_code
		end
	end

  after_validation :geocode, :reverse_geocode

  TEACHERS = %w{High\ School Middle\ School Elementary\ School}

  def self.get_teachers
  	TEACHERS
  end

	def self.from_omniauth(auth)
	  where(auth.slice(:provider, :uid)).first_or_create do |user|
	    user.provider = auth.provider
	    user.uid = auth.uid
	    user.speaker = "1"
	    user.first_name = auth.info.first_name
	    user.last_name = auth.info.last_name
	    user.email = auth.info.email
	    user.image = auth.info.image
	    user.bio = auth.info.description
	    user.industry = auth.info.industry
	    user.location = auth.info.location
	  end
    end

	def self.new_with_session(params, session)
	  if session["devise.user_attributes"]
	    new(session["devise.user_attributes"], without_protection: true) do |user|
	      user.attributes = params
	      user.valid?
	    end
	  else
	    super
	  end
	end

	def password_required?
		if !uid.blank?
			false
		else
			super
		end

	end

	def update_with_password(params, *options)
	  if encrypted_password.blank?
	    update_attributes(params, *options)
	  else
	    super
	  end
	end

	def self.find_speakers(query)
		results = []
		clean = []
		usrs = []
		if query[:location] && !query[:location].blank?
			results += near(query[:location], 20)
		end
		if query[:query] && !query[:query].blank?
			results += where("industry like ? OR bio like ?", "%#{query[:query]}%", "%#{query[:query]}%")
		end
		if results.empty?
			clean = where(speaker: "1")
		else
			results.each do |u| 
				if !usrs.include?(u.id) && u.speaker == "1"
				  clean << u
				  usrs  << u.id
				end
			end
		end
		clean
	end

	def self.copy_speaker_data
		where(speaker: "1").each do |u|
			if u.speaker_profile
				p = u.speaker_profile
				u.update_attributes(years: p.years, bio: p.bio, location: p.location, elementary: p.elementary, middle: p.middle, high: p.high, college: p.college, skype: p.skype, in_person: p.in_person)
			end
		end
	end
end
