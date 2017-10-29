class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :folders, :dependent => :destroy
  has_many :uploadfiles, :dependent => :destroy
  has_many :shared_folders, :dependent => :destroy
  has_many :being_shared_folders, :class_name => "Sharedfolder", :foreign_key => "shared_user_id", :dependent => :destroy
  has_many :shared_folders_by_others, :through => :being_shared_folders, :source => :folder	
  	#to check if a user has acess to this specific folder 
	def has_share_access?(folder) 
    	#has share access if the folder is one of one of his own 
    	return true if self.folders.include?(folder) 
  
    	#has share access if the folder is one of the shared_folders_by_others 
    	return true if self.shared_folders_by_others.include?(folder) 
  
    	#for checking sub folders under one of the being_shared_folders 
    	return_value = false
      print folder
    	folder.ancestors.each do |ancestor_folder| 
    
      		return_value = self.shared_folders_by_others.include?(ancestor_folder) 
      		p ancestor_folder  
          if return_value #if it's true 
        		return true
      		end
    	end
  
    	return false
	end
end
