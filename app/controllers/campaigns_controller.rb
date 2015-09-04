class CampaignsController < ApplicationController


	def campaign_creation
	end

	def creation_callback
		@campaign = Campaign.new(:title => params[:campaign][:title], :ownership => current_user.id, :preferred_currency => params[:campaign][:preferred_currency])
		@campaign.save
	end
end
