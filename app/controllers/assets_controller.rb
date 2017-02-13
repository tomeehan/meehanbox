class AssetsController < ApplicationController
  before_action :set_asset, only: [:show, :edit, :update, :destroy]

  def index
    @assets = current_user.assets
  end

  def show
    @asset = current_user.assets.find(params[:id])
  end

  def new
    @asset = current_user.assets.build

    if params[:folder_id] # if we want to upload a file inside a folder
      @current_folder = current_user.folders.find(params[:folder_id])
      @asset.folder_id = @current_folder.id
    end
  end

  def edit
    @asset = current_user.assets.find(params[:id]) 
  end

  def create
    @asset = current_user.assets.build(asset_params)

    respond_to do |format|
      if @asset.save!
        format.json { render :show, status: :created, location: @asset }
        if @asset.folder
          format.html { redirect_to browse_path(@asset.folder) , notice: 'File was successfully created.' }
        else
          format.html { redirect_to root_path, notice: 'File was successfully created.' }
        end
      else
        format.html { render :new }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @asset.update(asset_params)
        format.html { redirect_to assets_path, notice: 'File was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset }
      else
        format.html { render :edit }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @asset = current_user.assets.find(params[:id])
    @parent_folder = @asset.folder # get parent folder before deleting record
    @asset.destroy

    respond_to do |format|
      # redirect to parent folder
      if @parent_folder
        format.html { redirect_to browse_path(@parent_folder), notice: 'File was successfully deleted.' }
      else
        format.html { redirect_to root_path, notice: 'File was successfully deleted.' }
      end
      format.json { head :no_content }
    end
  end

  def get 
    asset = current_user.assets.find_by_id(params[:id])
      
    if asset
      #Parse the URL for special characters first before downloading 
      data = open(URI.parse(URI.encode(asset.uploaded_file.url)))
      data.to_s
      #then again, use the "send_data" method to send the above binary "data" as file. 
      send_data data, :filename => asset.uploaded_file_file_name, :x_sendfile => true
        
      #redirect to amazon S3 url which will let the user download the file automatically 
      #redirect_to asset.uploaded_file.url, :type => asset.uploaded_file_content_type 
    else
      flash[:error] = "Careful now! Those aren't yours."
      redirect_to root_url 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset
      @asset = Asset.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asset_params
      params.require(:asset).permit(:user_id, :uploaded_file_file_name, :uploaded_file_content_type, :uploaded_file_file_size, :uploaded_file_updated_at, :uploaded_file, :user_id, :uploaded_file, :folder_id)
    end
end
