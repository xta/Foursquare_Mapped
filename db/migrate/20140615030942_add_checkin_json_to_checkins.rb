class AddCheckinJsonToCheckins < ActiveRecord::Migration[4.2]
  def change
    add_column :checkins, :raw_json, :json
  end
end
