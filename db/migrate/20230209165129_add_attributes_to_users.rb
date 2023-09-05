class AddAttributesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nickname, :string
    add_column :users, :age, :integer
    add_column :users, :points_count, :integer
    add_column :users, :followers_count, :integer
  end
end
