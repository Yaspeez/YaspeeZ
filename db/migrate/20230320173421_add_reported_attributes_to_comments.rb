class AddReportedAttributesToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :reported_at, :datetime
    add_reference :comments, :reported_by, null: true, foreign_key: { to_table: :users }, type: :uuid
  end
end
