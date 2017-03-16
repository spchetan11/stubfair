class SearchesController < ApplicationController

	def index
		@event_search= Event.new
		@category=Catergory.all
	end

	def search
		# @event = Event.new(event_params)
		# title=@event.title
  #   	venue=@event.venue
  #   	categ=@event.category
  #   	puts(categ)
        if Rails.env.development?
		@search_result=Event.where("title LIKE ? or location LIKE ?", "%#{params[:search_text]}%" ,"%#{params[:search_text]}%").where(:published => true).paginate(:page => params[:page], :per_page => 16)
		elsif Rails.env.production?
		@search_result=Event.where("title ILIKE ? or location ILIKE ?", "%#{params[:search_text]}%" ,"%#{params[:search_text]}%").where(:published => true).paginate(:page => params[:page], :per_page => 16)
		end
		
	end

	private

	# def event_params
 #      params.require(:event).permit(:category, :title, :description, :venue, :genre, :event_date_time,:user_id, :expires_on, :ticket_attachment,:published)
 #    end

    # def search_params
    #   params.permit(:search_text)
    # end
end
