class CampaignsController < ApplicationController


	def campaign_creation
	end

	def show
		unless params[:title]
			@campaign = Campaign.new(:title => params[:campaign][:title], :ownership => current_user.id.to_i, :preferred_currency => params[:campaign][:preferred_currency], :views => "0")
			
			# saves the uploaded qr code
			raw_upload = params[:campaign][:uploaded_qr_code]
			upload_path = Rails.root.join('public', 'uploads', raw_upload.original_filename)
			File.open(upload_path, 'wb') do |file|
				file.write(raw_upload.read)
				#file.rename(raw_upload.read.to_s + raw_upload.original_filename.split('.')[-1])
			end

			require 'zxing'
			@campaign.qr_code = ZXing.decode(upload_path.to_s)
			@campaign.save
			redirect_to "/c/#{params[:campaign][:title]}"
		end
		@campaign = Campaign.find_by_title(params[:title])
		require 'open-uri'
		@current_bitcoin_price = JSON.parse(open('https://api.coindesk.com/v1/bpi/currentprice.json').read)['bpi']['USD']['rate']
		@campaign.views  # potentially could make it unique to each session
		@campaign.save
	end

	def index
		@campaigns = Campaign.all
	end
end