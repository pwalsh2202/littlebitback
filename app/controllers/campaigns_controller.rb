require 'open-uri'
class CampaignsController < ApplicationController

	def campaign_creation
		@campaign = Campaign.new
	end

	def create
		@campaign = Campaign.new(campaign_params)
		@campain.ownership = current_user.id
		current_user.add_project(@campaign)
		@campaign.save

		# dealing with cover image
		upload_path = Rails.root.join("app","assets","images","cover_images")
		image_name =  params[:campaign][:cover_image].original_filename
		File.open(upload_path + image_name, 'wb') do |f|
			f.write(params[:campaign][:cover_image].read)
		end
		#this is stupid notation, should be changed, but for some reason adding the strings kept adding an unnecessary "/" and broke the thing
		File.rename(upload_path.join(image_name), upload_path + "#{Campaign.find_by_title(params[:campaign][:title]).id.to_s}#{File.extname(image_name)}")

		redirect_to "/c/#{@campaign.title}"
	end

	def show
		@campaign = Campaign.find_by_title(params[:title])
		@campaign.views += 1
		@current_bitcoin_price = JSON.parse(open('https://api.coindesk.com/v1/bpi/currentprice.json').read)['bpi']['USD']['rate'].to_f.round(2)
		# potentially could make it unique to each session
		@campaign.save
	end

	def index
		@campaigns = Campaign.all
	end
	private
		def campaign_params
			#missing: uploaded_qr_code, tags
			#tags to come when dynamically searching for keywords
			params.require(:campaign).permit(:title,:type,:preferred_currency, :category,:qr_code, :goal, :description, :website)
    	end

end