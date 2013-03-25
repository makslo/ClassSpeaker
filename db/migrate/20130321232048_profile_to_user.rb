class ProfileToUser < ActiveRecord::Migration
  def change
    add_column :users, :bio, :text
    add_column :users, :industry, :string
    add_column :users, :location, :string
    add_column :users, :skills, :string
    add_column :users, :speak_about, :text
    add_column :users, :years, :integer, :default=>0
    add_column :users, :elementary, :boolean, :default=>false
    add_column :users, :middle, :boolean, :default=>false
    add_column :users, :high, :boolean, :default=>false
    add_column :users, :college, :boolean, :default=>false
    add_column :users, :new_user, :boolean, :default=>true
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :users, :address, :string
    add_column :users, :in_person, :boolean, :default=>false
    add_column :users, :skype, :boolean, :default=>false
  end
end
