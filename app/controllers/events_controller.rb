class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create,:update,:edit,:new, :destroy]
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    
  end
  def my_events
    @user = current_user.id
    @events=Event.where(:user_id => current_user.id).where(:published => true)
  end

  def concerts
    @events=Event.where(:published => true).where(:category => "Concerts")
  end

  def theatre
    @events=Event.where(:published => true).where(:category => "Theatre")
  end

  def sports
    @events=Event.where(:published => true).where(:category => "Sports")
  end

  def comedy
    @events=Event.where(:published => true).where(:category => "Comedy")
  end

  def festivals
    @events=Event.where(:published => true).where(:category => "Festivals")
  end

  def family
    @events=Event.where(:published => true).where(:category => "Family")
  end

  def deals
    @events=Event.where(:published => true).where(:category => "Deals")
  end

  def other
    @events=Event.where(:published => true).where(:category => "Other")
  end

  # GET /events/1
  # GET /events/1.json
  def show
    #only show users events

    @tickets_q=Ticket.new
    @events=Event.find(params[:id])
    @pictures = @events.pictures
    @picture_id=Picture.where(:event_id => @events.id)
    @img_paths="https://s3-us-west-2.amazonaws.com/pavan-events.s3.amazonaws.com/apps/public/images/" + @picture_id.first.id.to_s + "/"
    @tickets=Ticket.where(:event_id => @events.id).where(:published => true).order('ticket_selling_price ASC')
   
  end

  def search
    @event=Event.new
    @search_result={}
    #$title=params[:title]
    #$venue=params[:venue]
  end

  def ticket_step1

    #@event=Event.new
    @event = Event.new(event_params)
    #@event=params[:event]
    title=@event.title
    location=@event.location
    @search_result=Event.where("title LIKE ? and location LIKE ?", "%#{title}%" ,"%#{location}%").where(:published => true)
    #redirect_to '/event/search_result' 
    render 'events/search'


  end

  
  # GET /events/new
  def new

        @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create

    @event = Event.new(event_params)
    @event.user_id=current_user.id
        respond_to do |format|
          if @event.save
            if params[:images]
          # The magic is here for image handeling ;)
            params[:images].each { |image|
            @event.pictures.create(image: image)
          }
        end
            format.html { redirect_to @event, notice: 'Event was successfully created.' }
            format.json { render :show, status: :created, location: @event }
          else
            format.html { render :new }
            format.json { render json: @event.errors, status: :unprocessable_entity }
          end
        end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_edit_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

 

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
     #redirect_to events_url, notice: 'Event was successfully destroyed.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:category, :title, :description, :venue, :genre, :event_date_time,:user_id, :expires_on, :ticket_attachment,:published, :location, :pictures)
    end

    def event_edit_params
      params.require(:event).permit(:category, :title, :description, :venue, :genre, :event_date_time, :expires_on, :ticket_attachment, :location)
    end
end
