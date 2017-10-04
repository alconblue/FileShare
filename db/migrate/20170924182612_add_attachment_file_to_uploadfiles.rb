class AddAttachmentFileToUploadfiles < ActiveRecord::Migration
  def self.up
    change_table :uploadfiles do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :uploadfiles, :file
  end
end
