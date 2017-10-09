class SharedfoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sharedfolder, only: [:show, :edit, :update, :destroy]

  # GET /sharedfolders
  # GET /sharedfolders.json
  def index
    @sharedfolders = Sharedfolder.all
  end

  # GET /sharedfolders/1
  # GET /sharedfolders/1.json
  def show
  end

  # GET /sharedfolders/new
  def new
    @folder = Folder.find(params[:id])
    if @folder.user_id == current_user.id
      @sharedfolder = Sharedfolder.new
      @sharedfolder.user_id = current_user.id
      @sharedfolder.folder_id = @folder.id 
    end
    session[:id] = params[:id]
  end

  # GET /sharedfolders/1/edit
  def edit
  end

  # POST /sharedfolders
  # POST /sharedfolders.json
  def create
    @folder = Folder.find(session[:id])
    if @folder.user_id == current_user.id
      @sharedfolder = Sharedfolder.new(sharedfolder_params)
      @sharedfolder.user_id = current_user.id
      @sharedfolder.folder_id = @folder.id
      @user = User.where(:email => @sharedfolder.shared_email).first
      @sharedfolder.shared_user_id = @user.id
      @sharedfolder.save
    end

    respond_to do |format|
      if @sharedfolder.save
        format.html { redirect_to @sharedfolder, notice: 'Sharedfolder was successfully created.' }
        format.json { render :show, status: :created, location: @sharedfolder }
      else
        format.html { render :new }
        format.json { render json: @sharedfolder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sharedfolders/1
  # PATCH/PUT /sharedfolders/1.json
  def update
    respond_to do |format|
      if @sharedfolder.update(sharedfolder_params)
        format.html { redirect_to @sharedfolder, notice: 'Sharedfolder was successfully updated.' }
        format.json { render :show, status: :ok, location: @sharedfolder }
      else
        format.html { render :edit }
        format.json { render json: @sharedfolder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sharedfolders/1
  # DELETE /sharedfolders/1.json
  def destroy
    @sharedfolder.destroy
    respond_to do |format|
      format.html { redirect_to sharedfolders_url, notice: 'Sharedfolder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sharedfolder
      @sharedfolder = Sharedfolder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sharedfolder_params
      params.require(:sharedfolder).permit(:user_id, :shared_email, :shared_user_id, :folder_id, :message)
    end
end
