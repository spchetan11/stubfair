class WelcomeController < ApplicationController
  def index
  	@events=Event.all.where(:published=>"t")
  end
end
