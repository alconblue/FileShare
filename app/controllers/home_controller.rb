class HomeController < ApplicationController 
  before_action :authenticate_user!  
  def index 
	if user_signed_in?

     #show folders shared by others
     @shared = Sharedfolder.where(:shared_user_id => current_user.id).pluck(:folder_id)
     
     if @shared
      @being_shared_folders = Folder.where(:id => @shared)
	   else
      @being_shared_folders = []
     end 
     #show only root folders (which have no parent folders) 
     @folders = current_user.folders.roots.order("name")
       
     #show only root files which has no "folder_id" 
     @uploadfiles = current_user.uploadfiles.where("folder_id is NULL").order("file_file_name")       
    end 
  end

  def browse 
    #get the folders owned/created by the current_user 
    @current_folder = current_user.folders.find(params[:folder_id])   
    
    if @current_folder.nil? 
      folder = Folder.find_by_id(params[:folder_id]) 
      
      @current_folder ||= folder if current_user.has_share_access?(folder) 
      @is_this_folder_being_shared = true if @current_folder #just an instance variable to help hiding buttons on View   
    end
    
    if @current_folder
      
      #if under a sub folder, we shouldn't see shared folders
      @being_shared_folders = []

      #getting the folders which are inside this @current_folder 
      @folders = @current_folder.children.order("name")
  
      #We need to fix this to show files under a specific folder if we are viewing that folder 
      @uploadfiles = @current_folder.uploadfiles.order("file_file_name")

      render :action => "index"
    else
      flash[:error] = "Don't be cheeky! Mind your own folders!"
      redirect_to root_url 
    end
  end
end