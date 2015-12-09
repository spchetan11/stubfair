class BandsController < ApplicationController
	
	def band
	  @band = Band.find_by_id(1)

	  @current_user_band = Band.where(:user_id => current_user.id)

    end
end
