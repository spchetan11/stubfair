class WelcomeController < ApplicationController
  def index
  	@events=Event.all.where(:published=>"t").paginate(:page => params[:page], :per_page => 16)
  end
end
