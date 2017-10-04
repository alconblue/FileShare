class HomeController < ApplicationController 
  before_action :authenticate_user!  
  def index 
	if user_signed_in? 
      @uploadfiles = current_user.uploadfiles.order("file_file_name desc")       
    end 
  end
end