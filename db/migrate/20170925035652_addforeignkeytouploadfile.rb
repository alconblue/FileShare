class Addforeignkeytouploadfile < ActiveRecord::Migration[5.0]
  def change
  	add_foreign_key :uploadfiles, :users
  end
end
