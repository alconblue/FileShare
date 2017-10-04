class CreateFolders < ActiveRecord::Migration[5.0]
  def change
    create_table :folders do |t|
      t.references :user, foreign_key: true
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
  end
end
