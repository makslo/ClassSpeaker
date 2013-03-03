class CreateSpeakerProfiles < ActiveRecord::Migration
  def change
    create_table :speaker_profiles do |t|
      t.integer :user_id
      t.string :career
      t.integer :years
      t.string :location
      t.text :bio
      t.boolean :elementary
      t.boolean :middle
      t.boolean :high
      t.boolean :college
      t.boolean :in_person
      t.boolean :skype

      t.timestamps
    end
  end
end
