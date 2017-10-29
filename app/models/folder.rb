class Folder < ApplicationRecord
  acts_as_tree	
  belongs_to :user
  has_many :uploadfiles, :dependent => :destroy
  has_many :sharedfolders, :dependent => :destroy
end
