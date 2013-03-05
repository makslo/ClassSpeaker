class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :count
      t.string :email_to
      t.string :email_from
      t.string :date

      t.timestamps
    end
  end
end
