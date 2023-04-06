class AddGeocodingToActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :latitude, :float
    add_column :activities, :longitude, :float
    add_column :activities, :address, :string
    add_column :activities, :postal_code, :string
    add_column :activities, :city, :string
    add_column :activities, :country_code, :string
  end
end
