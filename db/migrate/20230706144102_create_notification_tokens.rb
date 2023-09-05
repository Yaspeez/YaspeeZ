class CreateNotificationTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_tokens, id: :uuid do |t|
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid
      t.string :platform
      t.string :token

      t.timestamps
    end
  end
end
