class RenameCityNameInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :city, :city_name
  end
end
