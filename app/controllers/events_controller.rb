class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create,:update,:edit,:new, :destroy]
  skip_before_filter :verify_authenticity_token
  # GET /events
  # GET /events.json
  def index
    @events = Event.all.where(:published=> true).paginate(:page => params[:page], :per_page => 16)
    @popular_events = PopularEvent.all


    @events.each do |event|
    @image=EventImage.where(:event_id => event.id)
    # @image.each do |img|
    #   @url=img.image_url
    #   puts("url is")
    #   puts(@url)
    # end
  end

    
  end
  def my_events
    @user = current_user.id
    @events=Event.where(:user_id => current_user.id).where(:published => true).paginate(:page => params[:page], :per_page => 16)
  end

  def concerts
    @events=Event.where(:published => true).where(:category => "Concerts").paginate(:page => params[:page], :per_page => 16)
  end

  def theatre
    @events=Event.where(:published => true).where(:category => "Theatre").paginate(:page => params[:page], :per_page => 16)
  end

  def sports
    @events=Event.where(:published => true).where(:category => "Sports").paginate(:page => params[:page], :per_page => 16)
  end

  def comedy
    @events=Event.where(:published => true).where(:category => "Comedy").paginate(:page => params[:page], :per_page => 16)
  end

  def festivals
    @events=Event.where(:published => true).where(:category => "Festivals").paginate(:page => params[:page], :per_page => 16)
  end

  def family
    @events=Event.where(:published => true).where(:category => "Family").paginate(:page => params[:page], :per_page => 16)
  end

  def deals
    @events=Event.where(:published => true).where(:category => "Deals").paginate(:page => params[:page], :per_page => 16)
  end

  def other
    @events=Event.where(:published => true).where(:category => "Other").paginate(:page => params[:page], :per_page => 16)
  end

  def upcoming
    @events=Event.upcoming.where(:published => true)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    #only show users events

    @tickets_q=Ticket.new
    @events=Event.find(params[:id])
    loc=@events.location
    if Rails.env.development?
    @related=Event.where("location LIKE ?","%#{loc}%").where(:published =>true)
    elsif Rails.env.production?
    @related=Event.where("location ILIKE ?","%#{loc}%").where(:published =>true)
    end  
    #@event_image = @events.event_images
    @image=EventImage.where(:event_id => @events.id)
    @image.each do |img|
      @url=img.image_url
      puts("url is")
      puts(@url)
    end
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
    # @event = Event.new(event_params)
    #@event=params[:event]
    # title=@event.title
    # location=@event.location
    if Rails.env.development?
    @search_result=Event.where("title LIKE ? or location LIKE ?", "%#{params[:search_text]}%" ,"%#{params[:search_text]}%").where(:published => true).paginate(:page => params[:page], :per_page => 16)
    elsif Rails.env.production?
    @search_result=Event.where("title ILIKE ? or location ILIKE ?", "%#{params[:search_text]}%" ,"%#{params[:search_text]}%").where(:published => true).paginate(:page => params[:page], :per_page => 16)
    end
    #redirect_to '/event/search_result' 
    render 'events/search'


  end

  def popular_events
    @event = Event.new(event_params)
    #@event=params[:event]
    title=@event.title
    location=@event.location
     if Rails.env.development?
    @search_result=Event.where("title LIKE ?", "%#{title}%").where(:published => true).paginate(:page => params[:page], :per_page => 16)
    elsif Rails.env.production?
      @search_result=Event.where("title ILIKE ?", "%#{title}%").where(:published => true).paginate(:page => params[:page], :per_page => 16)
    end
    #redirect_to '/event/search_result' 
    render 'events/popular_events'
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
    #@event.user_id=current_user.id
    
        respond_to do |format|
          if @event.save
            @event.update_attributes(:user_id => current_user.id)

            if params[:attachments]
          # The magic is here for image handeling ;)
            params[:attachments].each { |image|
            @pic=@event.event_images.create(attachment: image)
            @event.event_images.update_all(:image_url => @pic.attachment.url)
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

     # @as = @event.pictures.create(image: image)
     #        puts @as.image.url
     #        if @as.image.url
     #        @event.pictures.update_all(:image_url => @as.image.url)
     #         end
     #       }

     #puts "URL is #{Picture.first.image.url}"

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
      params.require(:event).permit(:category, :title, :description, :venue, :event_date_time,:user_id, :expires_on, :published, :location, :event_image,:stadium_image_url)
    end

    def event_edit_params
      params.require(:event).permit(:category, :title, :description, :venue, :event_date_time, :expires_on, :location,:stadium_image_url)
    end
end
