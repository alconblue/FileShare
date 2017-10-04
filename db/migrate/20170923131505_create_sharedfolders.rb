class CreateSharedfolders < ActiveRecord::Migration[5.0]
  def change
    create_table :sharedfolders do |t|
      t.references :user, foreign_key: true
      t.string :shared_email
      t.integer :shared_user_id
      t.references :folder, foreign_key: true
      t.string :message

      t.timestamps
    end
  end
end
