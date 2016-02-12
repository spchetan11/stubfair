class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy, :payment]
  before_action :authenticate_user!, only: [:create,:update,:edit,:new]
  # GET /tickets
  # GET /tickets.json
  def index
   @tickets = Ticket.where(:user_id => current_user.id).paginate(:page => params[:page], :per_page => 20)
  end
  # GET /tickets/1
  # GET /tickets/1.json
  def show
    #only show users tickets
    #@tickets = Ticket.where(:user_id => current_user.id)
  end

  def ticket_updated
    #only show users tickets
    #@tickets = Ticket.where(:user_id => current_user.id)
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    @event=Event.find(params[:event_id])
    #puts(@event.id)
    @transaction = Transaction.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create

    @ticket = Ticket.new(ticket_params)
    #@ticket.user_id=current_user.id

    #paypal_email=params[:user][:paypal_email]
    #puts("this is paypal_email #{paypal_email}")
    @user=User.find_by_id(params[:current_user_id])
   
    @event=Event.find(params[:event_id])
    #seller_id=current_user.id
        respond_to do |format|
          if@ticket.save
            
            if params[:images]
          # The magic is here for image handeling ;)
            params[:images].each { |image|
            @pic=@ticket.ticket_images.create(image: image)
            @ticket.ticket_images.update_all(:image_url => @pic.image.url)
           }
            end
          
          if(@user.paypal_email.blank?)
            @user.update(:paypal_email => params[:user][:paypal_email]) 
          end
            @ticket.update_attributes(:event_id => @event.id, :user_id => current_user.id)
            format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
            format.json { render :show, status: :created, location: @ticket}
          else
            format.html { render :new }
            format.json { render json: @ticket.errors, status: :unprocessable_entity }
          end
        end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :ticket_updated, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 #  {"number_of_tickets"=>"3",
 # "ticket_number"=>"121212",
 # "ticket_selling_price"=>"600.0",
 # "ticket_type"=>"Electronic",
 # "id"=>"12"}

  def payment
    # amount = params[:ticket_selling_price]
    # type_of_ticket = params[:ticket_type]
    Transaction.where(:user_id => current_user.id).where(:status => nil).destroy_all
    no_of_ticket= params["number_of_tickets"]
    events_id = params["event_id"]
    #puts(events_id)
    @event=Event.find(params[:event_id])
    event_name = @event.title
    #puts(event_name)
    #quant=session[:quantity].to_i
    @ticket = Ticket.find(params[:id])
    @user = current_user.id
    @transaction = Transaction.new
    @transaction.update(:ticket_id => @ticket.id, :ticket_created_at => @ticket.created_at, :ticket_updated_at => @ticket.updated_at, :user_id => @user, :event_id => @ticket.event_id, :number_of_tickets => @ticket.number_of_tickets, :ticket_selling_price => @ticket.ticket_selling_price, :ticket_printed_price => @ticket.ticket_printed_price, :booking_id => @ticket.booking_id, :published => @ticket.published, :ticket_type => @ticket.ticket_type, :seller_id => @ticket.user_id, :row => @ticket.row, :seat_number => @ticket.seat_number, :section => @ticket.section)
    tx_id = @transaction.id
    #puts(tx_id)
    #puts("this is id")
    # seller_user_id=@transaction.seller_id
    # seller=User.find(seller_user_id)
    # puts("seller id is #{seller_user_id}")
    # puts("user is #{seller.email}")
    
    redirect_to  @transaction.ticket.paypal_url(transaction_path,no_of_ticket,event_name,tx_id)
    
    
  end

  protect_from_forgery except: [:hook]
  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      puts "successfully completed the transaction"
      #@transaction = Transaction.find params[:invoice]
      #@transaction.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
    params.require(:ticket).permit(:user_id, :event_id, :published,  :number_of_tickets, :ticket_type, :ticket_printed_price, :ticket_selling_price, :ticket_number, :booking_id, :ticket_images, :row, :seat_number, :section)
    end

  

end



