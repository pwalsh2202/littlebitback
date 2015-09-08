class CampaignsController < ApplicationController


	def campaign_creation
	end

	def show
		unless params[:title]
			@campaign = Campaign.new(:title => params[:campaign][:title], :ownership => current_user.id.to_i, :preferred_currency => params[:campaign][:preferred_currency])
			@campaign.save
			# saves the uploaded qr code
			raw_upload = params[:campaign][:uploaded_qr_code]
			File.open(Rails.root.join('public', 'uploads', raw_upload.original_filename), 'wb') do |file|
				 file.write(raw_upload.read)
			end
			
			redirect_to "/c/#{@campaign}"
		end
		@campaign = Campaign.find_by_title(params[:title].gsub('%20', ' '))
	end
end