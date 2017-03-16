class BandsController < ApplicationController
	
	def band
	  @band = Band.find_by_id(1)

	  @current_user_band = Band.where(:id => current_user.buyer_band)

    end
end
