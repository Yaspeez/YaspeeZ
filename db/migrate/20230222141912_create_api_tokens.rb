class CreateApiTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :api_tokens, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.string :token

      t.timestamps
    end
  end
end
