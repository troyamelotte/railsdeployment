class CreateSecrets < ActiveRecord::Migration
  def change
    create_table :secrets do |t|
      t.string :secret
      t.integer :total_likes
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :secrets, :users
  end
end
