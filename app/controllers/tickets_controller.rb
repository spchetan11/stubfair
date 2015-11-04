class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy, :payment]
  before_action :authenticate_user!, only: [:create,:update,:edit,:new]
  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all
  end
  
  # GET /tickets/1
  # GET /tickets/1.json
  def show
    #only show users tickets
    #@user = current_user.id
    
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    @event=Event.find(params[:events_id])
    #puts(@event.id)
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create

    @ticket = Ticket.new(ticket_params)
    @ticket.user_id=current_user.id
    @event=Event.find(params[:events_id])
    seller_id=current_user.id
        respond_to do |format|
          if@ticket.save
             
             @ticket.update_attributes(:seller_id => seller_id, :events_id => @event.id, :user_id => session[:id])
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
        format.json { render :show, status: :ok, location: @ticket }
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

  def payment
    #puts "this was called"
    redirect_to @ticket.paypal_url(ticket_path(@ticket))
    
  end

  protect_from_forgery except: [:hook]
  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      puts "successfully completed the transaction"
      # @ticket = Ticket.find params[:invoice]
      # @ticket.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end

  def self.send_money(to_email, how_much_in_cents, options = {})
  credentials = {
    "USER" => "chetan-seller_api1.gmail.com",
    "PWD" => "J7AXDX3QQWVU2UZ2",
    "SIGNATURE" => "AFcWxV21C7fd0v3bYYYRCpSSRl31ADb9r-ueKABlYKBV2b6tCmWKZuYq"
  }
 
  params = {
    "METHOD" => "MassPay",
    "CURRENCYCODE" => "USD",
    "RECEIVERTYPE" => "EmailAddress",
    "L_EMAIL0" => to_email,
    "L_AMT0" => ((how_much_in_cents.to_i)/100.to_f).to_s,
    "VERSION" => "51.0"
  }
 
  endpoint = RAILS_ENV == 'production' ? "https://api-3t.paypal.com" : "https://api-3t.sandbox.paypal.com"
  url = URI.parse(endpoint)
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  all_params = credentials.merge(params)
  stringified_params = all_params.collect { |tuple| "#{tuple.first}=#{CGI.escape(tuple.last)}" }.join("&")
 
  response = http.post("/nvp", stringified_params)
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
    params.require(:ticket).permit(:seller_id, :user_id, :events_id, :published, :comments,  :number_of_tickets, :ticket_type, :ticket_printed_price, :ticket_selling_price, :ticket_number)
    end

  

end



