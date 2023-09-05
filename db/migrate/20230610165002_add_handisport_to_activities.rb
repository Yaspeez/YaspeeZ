class AddHandisportToActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :handisport, :boolean, default: false
  end
end
