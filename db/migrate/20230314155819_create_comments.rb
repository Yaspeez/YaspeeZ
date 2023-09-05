class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments, id: :uuid do |t|
      t.references :activity, null: false, foreign_key: true, type: :uuid
      t.references :author, null: false, foreign_key: true, type: :uuid, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
