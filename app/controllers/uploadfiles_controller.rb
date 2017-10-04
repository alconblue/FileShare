class UploadfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_uploadfile, only: [:show, :edit, :update, :destroy]

  # GET /uploadfiles
  # GET /uploadfiles.json
  def index
    @uploadfiles = Uploadfile.all
  end

  # GET /uploadfiles/1
  # GET /uploadfiles/1.json
  def show
  end

  # GET /uploadfiles/new
  def new
    @uploadfile = Uploadfile.new
    @uploadfile.user_id = current_user.id
    @uploadfile.save
  end

  # GET /uploadfiles/1/edit
  def edit
  end

  # POST /uploadfiles
  # POST /uploadfiles.json
  def create
    @uploadfile = Uploadfile.new(uploadfile_params)
    @uploadfile.user_id = current_user.id
    @uploadfile.save
    respond_to do |format|
      if @uploadfile.save
        format.html { redirect_to @uploadfile, notice: 'Uploadfile was successfully created.' }
        format.json { render :show, status: :created, location: @uploadfile }
      else
        format.html { render :new }
        format.json { render json: @uploadfile.errors, status: :unprocessable_entity }
      end
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
    @uploadfile.destroy
    respond_to do |format|
      format.html { redirect_to uploadfiles_url, notice: 'Uploadfile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get 
    uploadfile = Uploadfile.find_by_id(params[:id]) 
    if uploadfile and uploadfile.user_id = current_user.id
      send_file uploadfile.file.path
    else
      flash[:error] = "Don't be cheeky! Mind your own assets!"
      redirect_to uploadfiles_path   
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uploadfile
      @uploadfile = Uploadfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def uploadfile_params
      params.require(:uploadfile).permit(:folder_id, :file)
    end
end
