class HomeController < ApplicationController

	def index
		if user_signed_in? 
			@folders = current_user.folders.order("name desc")   
      		@assets = current_user.assets.order("uploaded_file_file_name desc")       
    	end
	end
	
	def browse
		@current_folder = current_user.folders.find(params[:folder_id])

		if @current_folder
			@folders = @current_folder.children
			@assets = @current_folder.assets.order("uploaded_file_file_name desc")
			render :action => "index"
		else
			flash[:error] = "Whoa there! That's not your folder!"
			redirect_to root_path
		end
	end

end