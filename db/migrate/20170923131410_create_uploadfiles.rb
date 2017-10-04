class CreateUploadfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :uploadfiles do |t|
      t.references :folder, foreign_key: true

      t.timestamps
    end
  end
end
