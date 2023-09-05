class RenameCityNameInActivities < ActiveRecord::Migration[7.0]
  def change
    rename_column :activities, :city, :city_name
  end
end
