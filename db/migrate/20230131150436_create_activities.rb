class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities, id: :uuid do |t|
      t.float :duration_in_minutes
      t.string :gender
      t.string :level
      t.integer :maximum_participants_number
      t.integer :participants_count
      t.integer :per_participant_price_cents
      t.datetime :starts_at
      t.references :sport, null: false, foreign_key: true, type: :uuid
      t.references :owner, null: false, foreign_key: { to_table: :users }, type: :uuid

      t.timestamps
    end
  end
end
