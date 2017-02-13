class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  
  # GET /folders
  # GET /folders.json
  def index
    @folders = current_user.folders
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
     @folder = current_user.folders.find(params[:id]) 
  end

  # GET /folders/new
  def new
    @folder = current_user.folders.new

    # if there is a folder_id param, the folder is in another folder.
    if params[:folder_id]
      @current_folder = current_user.folders.find(params[:folder_id])
      @folder.parent_id = @current_folder.id
    end
  end

  # GET /folders/1/edit
  def edit
    @folder = current_user.folders.find(params[:folder_id]) 
    @current_folder = @folder.parent
    # TODO: "Couldn't find Folder with 'id'="
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = current_user.folders.new(folder_params)

    respond_to do |format|
      if @folder.save
        format.json { render :show, status: :created, location: @folder }

        if @folder.parent
          format.html { redirect_to browse_path(@folder.parent), notice: t('folder.notice.create_successful') }
        else
          format.html { redirect_to root_path, notice: t('folder.notice.create_successful') }
        end
      else
        format.html { render :new }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    @folder = current_user.folders.find(params[:id])
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to @folder, notice: t('folder.notice.update_successful') }
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
    @folder = current_user.folders.find(params[:id]) 
    @parent_folder = @folder.parent # get parent folder 

    @folder.destroy # destroys the folder, and everything inside.

    # redirect to relevent folder
    respond_to do |format|
      if @parent_folder
        format.html { redirect_to browse_path(@parent_folder), notice: t('folder.notice.delete_successful') }
      else
        format.html { redirect_to root_path, notice: t('folder.notice.delete_successful') }
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
      params.require(:folder).permit(:name, :parent_id, :user_id)
    end
end
