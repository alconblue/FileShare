class Uploadfile < ApplicationRecord
  belongs_to :folder
  belongs_to :user
  has_attached_file :file,
  					:url => "/assets/get/:id",
  					:path => ":Rails_root/assets/:id/:basename.:extension"
  do_not_validate_attachment_file_type :file
  validates_attachment_size :file, :less_than => 50.megabytes

end
