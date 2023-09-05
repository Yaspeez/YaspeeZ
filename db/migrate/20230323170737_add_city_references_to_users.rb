class AddCityReferencesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :city, null: true, foreign_key: true, type: :uuid
  end
end
