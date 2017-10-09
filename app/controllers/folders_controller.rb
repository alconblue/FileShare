class FoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder, only: [:show, :edit, :update, :destroy]

  # GET /folders
  # GET /folders.json
  def index
    @folders = current_user.folders.all
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
  end

  # GET /folders/new
  def new
    @folder = current_user.folders.new
    if params[:folder_id] 
     @current_folder = current_user.folders.find(params[:folder_id]) 
     @folder.parent_id = @current_folder.id
     @folder.save 
   end
  end

  # GET /folders/1/edit
  def edit
    @current_folder = @folder.parent
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = current_user.folders.new(folder_params)
    if @folder.save
      if @folder.parent
        redirect_to browse_path(@folder.parent)
      else
        redirect_to root_url
      end
    else
      render :action => 'new'
    end
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to @folder, notice: 'Folder was successfully updated.' }
        format.json { render :show, status: :ok, location: @folder }
      else
        format.html { render :edit }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @parent_folder = @folder.parent #grabbing the parent folder 
  
    #this will destroy the folder along with all the contents inside 
    #sub folders will also be deleted too as well as all files inside 
    @folder.destroy 
    flash[:notice] = "Successfully deleted the folder and all the contents inside."
  
    #redirect to a relevant path depending on the parent folder 
    if @parent_folder
      redirect_to browse_path(@parent_folder) 
    else
      redirect_to root_url       
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = current_user.folders.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
      params.require(:folder).permit(:user_id, :parent_id, :name)
    end
end
