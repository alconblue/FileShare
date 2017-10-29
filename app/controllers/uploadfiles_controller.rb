class UploadfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_uploadfile, only: [:show, :edit, :update, :destroy]

  # GET /uploadfiles
  # GET /uploadfiles.json
  def index
    @uploadfiles = current_user.uploadfiles.all
  end

  # GET /uploadfiles/1
  # GET /uploadfiles/1.json
  def show
  end

  # GET /uploadfiles/new
  def new
    @uploadfile = current_user.uploadfiles.new
    if params[:folder_id] #if we want to upload a file inside another folder 
      @current_folder = current_user.folders.find(params[:folder_id]) 
      @uploadfile.folder_id = @current_folder.id
      @uploadfile.save
    end
  end

  # GET /uploadfiles/1/edit
  def edit
  end

  # POST /uploadfiles
  # POST /uploadfiles.json
  def create
    @uploadfile = current_user.uploadfiles.new(uploadfile_params) 
    if @uploadfile.save 
      flash[:notice] = "Successfully uploaded the file."
  
      if @uploadfile.folder #checking if we have a parent folder for this file 
        redirect_to browse_path(@uploadfile.folder)  #then we redirect to the parent folder 
      else
        redirect_to root_url 
      end      
    else
      render :action => 'new'
    end
  end

  # PATCH/PUT /uploadfiles/1
  # PATCH/PUT /uploadfiles/1.json
  def update
    respond_to do |format|
      if @uploadfile.update(uploadfile_params)
        format.html { redirect_to @uploadfile, notice: 'Uploadfile was successfully updated.' }
        format.json { render :show, status: :ok, location: @uploadfile }
      else
        format.html { render :edit }
        format.json { render json: @uploadfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploadfiles/1
  # DELETE /uploadfiles/1.json
  def destroy
    @parent_folder = @uploadfile.folder #grabbing the parent folder before deleting the record 
    @uploadfile.destroy
    flash[:notice] = "Successfully deleted the file."
    if @parent_folder
      redirect_to browse_path(@parent_folder) 
    else
      redirect_to root_url 
    end
  end

  def get 
    uploadfile = current_user.uploadfiles.find_by_id(params[:id])
    uploadfile ||= Uploadfile.find(params[:id]) if current_user.has_share_access?(Uploadfile.find_by_id(params[:id]).folder) 
    if uploadfile
      send_file uploadfile.file.path
      return
    else
      flash[:error] = "Don't be cheeky! Mind your own files!"
      redirect_to root_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uploadfile
      @uploadfile = current_user.uploadfiles.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def uploadfile_params
      params.require(:uploadfile).permit(:folder_id, :file)
    end
end
