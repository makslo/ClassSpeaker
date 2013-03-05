class Booking < ActiveRecord::Base
  attr_accessible :count, :date, :email_from, :email_to
end
