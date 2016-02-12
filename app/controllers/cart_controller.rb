class CartController < ApplicationController
  require 'cart'
 
  before_action :authenticate_user!, except: [:index]
	#if there is a cart, pass it to the page for display else pass an empty value
  def index

  	if session[:cart] then
  		@cart = session[:cart]
  	else
      #session[:cart] = nil
  		@cart = {}
  	end
  end

  def add

  	id = params[:id]
    q = params[:ticket][:number_of_tickets]
    q=q.to_i
    #@global_q=q
    session[:quantity] = q
    #puts(q)
  	#if the cart has already been created, use the  existing cart else create a new cart
  	if session[:cart] then
  		cart = session[:cart]
  	else
  		session[:cart] = {}
  		cart = session[:cart]
  	end
  		# if the product has already been added to the card, increase its value else set it to 1
  		#if cart[id] then
  		#	cart[id] = cart[id] + 1
      if (q > 1)
        cart[id]= q
  		else
  			cart[id] = 1
  		end
  
  		redirect_to :action => :index
  	end #end add method

  # def checkout
  #   #this is checkout/ for testing, just add to transactions table
  #   #puts(params[:id])
  #   e_id=Ticket.find(params[:id])
  #   e_id=e_id.events_id
  #   #we now have event id in e_id
  #   @e_checkout=Event.where(:id => e_id)
    
  #   #add decrement
  #   @det_id=Ticket.find(params[:id])
  #   #puts(det_id)
  #   quant=session[:quantity].to_i
  #   #puts(quant)
  #   delta = @det_id.number_of_tickets# - quant
  #   #puts(@det_id.number_of_tickets)
  #   puts(delta)
  #   @det_id.update_attributes(:number_of_tickets => delta)
  #   #@det_id.update
    

  # end


  def clearCart
  	session[:cart] = nil
  	redirect_to :action => :index
  end





end
