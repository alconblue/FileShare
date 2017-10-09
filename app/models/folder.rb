class Folder < ApplicationRecord
  acts_as_tree	
  belongs_to :user
  has_many :uploadfiles, :dependent => :destroy
  has_many :shared_folders, :dependent => :destroy
end
