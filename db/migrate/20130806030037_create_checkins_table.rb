class CreateCheckinsTable < ActiveRecord::Migration
  def change
    create_table :checkins do |t|

			t.integer :created
			t.string :ci_id
			t.string :ci_type
			t.string :timezoneoffset

			t.string :venue_id
			t.string :venue_name

			t.string :venue_location_address
			t.string :venue_location_city
			t.string :venue_location_state
			t.string :venue_location_crossStreet
			t.string :venue_location_postalCode
			t.string :venue_location_country
			t.string :venue_location_cc
			t.string :venue_location_lat
			t.string :venue_location_lng

			t.integer :user_id

			t.timestamps
    end
  end
end
