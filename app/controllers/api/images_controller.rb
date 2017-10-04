class Api::ImagesController < ApiController
  before_action :authenticate_admin!

	def create
		image = Cloudinary::Uploader.upload(params[:file])
		render json: {url: image["secure_url"]}
	end
end