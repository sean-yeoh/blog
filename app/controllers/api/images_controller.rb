class Api::ImagesController < ApiController
	def create
		image = Cloudinary::Uploader.upload(params[:file])
		render json: {url: image["secure_url"]}
	end
end