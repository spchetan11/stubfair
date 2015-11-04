class SearchesController < ApplicationController

	def index
		@event_search= Event.new
		@category=Catergory.all
	end

	def search
		@event = Event.new(event_params)
		title=@event.title
    	venue=@event.venue
    	categ=@event.category
    	puts(categ)
		@search_result=Event.where("title LIKE ? and venue LIKE ?", "%#{title}%" ,"%#{venue}%").where(:published => true,:category => @event.category)
	end

	private

	def event_params
      params.require(:event).permit(:category, :title, :description, :venue, :genre, :event_date_time,:user_id, :expires_on, :ticket_attachment,:published)
    end
end
