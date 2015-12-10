class EventImagesController < ApplicationController
	# GET /pictures
  # GET /pictures.json
  def index

    @event = Event.find(params[:id])

    @pictures = @event.pictures

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pictures }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @picture = Picture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.json
  def new
    @event = Event.find(params[:id])
    @event_image = @event.event_images.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event_image }
    end
  end

  # GET /pictures/1/edit
  def edit
    

    @picture = Picture.find(params[:id])
    # @picture = Picture.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @event_image = EventImage.new(params[:event_image])

    if @event_image.save
      respond_to do |format|
        format.html {
          render :json => [@event_image.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json {
          render :json => [@event_image.to_jq_upload].to_json
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.json
  def update

    @event = Event.find(params[:id])

    @picture = @event.pictures.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(picture_params)
        format.html { redirect_to event_path(@event), notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    
    @picture = Picture.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def make_default
    @picture = Picture.find(params[:id])
    @event = Event.find(params[:id])

    @event.cover = @picture.id
    @event.save

    respond_to do |format|
      format.js
    end
  end

  private

  def picture_params
    params.require(:event_image).permit(:attachment,:id, :image_url)
  end
end
