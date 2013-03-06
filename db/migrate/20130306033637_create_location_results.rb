class CreateLocationResults < ActiveRecord::Migration
  def change
    create_table :location_results do |t|
      t.string :term
      t.integer :popularity

      t.timestamps
    end
  end
end
