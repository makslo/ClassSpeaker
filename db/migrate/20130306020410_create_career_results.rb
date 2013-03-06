class CreateCareerResults < ActiveRecord::Migration
  def change
    create_table :career_results do |t|
      t.string :term
      t.integer :popularity

      t.timestamps
    end
  end
end
