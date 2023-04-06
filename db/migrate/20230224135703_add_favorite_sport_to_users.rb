class AddFavoriteSportToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :sport, null: true, foreign_key: true, type: :uuid
  end
end
