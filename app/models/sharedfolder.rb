class Sharedfolder < ApplicationRecord
  belongs_to :user
  belongs_to :folder
  belongs_to :shared_user, :class_name => "User", :foreign_key => "shared_user_id", optional: true
end
