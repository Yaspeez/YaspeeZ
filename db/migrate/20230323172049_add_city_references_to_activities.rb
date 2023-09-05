class AddCityReferencesToActivities < ActiveRecord::Migration[7.0]
  def change
    add_reference :activities, :city, null: true, foreign_key: true, type: :uuid
  end
end
