class AddCheckinJsonToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :raw_json, :json
  end
end
