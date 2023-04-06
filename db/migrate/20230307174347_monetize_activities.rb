class MonetizeActivities < ActiveRecord::Migration[7.0]
  def change
    remove_column :activities, :per_participant_price_cents
    add_monetize :activities, :per_participant_price
  end
end
