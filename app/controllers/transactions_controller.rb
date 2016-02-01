class TransactionsController < ApplicationController
    before_action :set_transactions, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:create,:update,:edit,:new]
    skip_before_action :verify_authenticity_token

# def purchase
#   @ticket = Ticket.find(params[:id])
    
#     @user = current_user.id
#   @purchase = Transaction.new

#     #SHOULD ADD below - number_of_tickets_purchased, purchase_flag, event_expires_on 

#   @user_transaction = @purchase.update(:ticket_id => @ticket.id,:comments => @ticket.comments, :ticket_created_at => @ticket.created_at, :ticket_updated_at => @ticket.updated_at, :user_id => @user, :event_id => @ticket.events_id, :number_of_tickets => @ticket.number_of_tickets, :ticket_selling_price => @ticket.ticket_selling_price, :ticket_printed_price => @ticket.ticket_printed_price, :ticket_number => @ticket.ticket_number, :published => @ticket.published, :ticket_type => @ticket.ticket_type)
#     @ticket_i=Ticket.new
#     @purchase_history=Transaction.where(:user_id => @user)
#     #pull_event=@purchase_history.event_id
#     #@event_i=Event.where(:event_id => pull_event)
#     @event_i=''
# end

   def paypal_redirect
        #item_number is ticket_id from the paypal response
        e_id=Ticket.find(params[:id])
        e_id=e_id.event_id
        #we now have event id in e_id
        @e_checkout=Event.where(:id => e_id)
        
        #add decrement
        @det_id=Ticket.find(params[:id])
        #puts(det_id)
        quant=session[:quantity].to_i
        #puts(quant)
        delta = @det_id.number_of_tickets# - quant
        #puts(@det_id.number_of_tickets)
        puts(delta)
        @det_id.update_attributes(:number_of_tickets => delta)

       #----------

        @ticket = Ticket.find(params[:id])
        
        @user = current_user ? current_user.id : nil
        @purchase = Transaction.new

        #SHOULD ADD below - number_of_tickets_purchased, purchase_flag, event_expires_on 
        txn_id = params[:txn_id]
        status = params[:payment_status]
        payment_gross = params[:payment_gross]
        quantity = params[:quantity]

        #@user_transaction = @purchase.update(:ticket_id => @ticket.id,:comments => @ticket.comments, :ticket_created_at => @ticket.created_at, :ticket_updated_at => @ticket.updated_at, :user_id => @user, :event_id => @ticket.event_id, :number_of_tickets => @ticket.number_of_tickets, :ticket_selling_price => @ticket.ticket_selling_price, :ticket_printed_price => @ticket.ticket_printed_price, :ticket_number => @ticket.ticket_number, :published => @ticket.published, :ticket_type => @ticket.ticket_type, number_of_tickets_purchased: quant)
        if status == "Completed"
            @transaction = Transaction.find params[:invoice]
            seller_user_id=@transaction.seller_id
            seller=User.find(seller_user_id)
            #puts("seller id is #{seller_user_id}")
            #puts("user is #{seller.email}")
           
            @user_transaction = @transaction.update(status: status, transaction_id: txn_id, purchased_at: Time.now, purchase_amount: payment_gross, number_of_tickets_purchased: quant, :purchased => true)
            #incrementing the tickets purchased column in tickets table for this ticket for calculation of available tickets in events.show page.
            @ticket_id = @transaction.ticket_id
            @ticket = Ticket.find_by_id(@ticket_id)
            @ticket.increment!(:number_of_tickets_purchased, quant)

            session[:cart] = nil

            respond_to do |format|
              format.pdf do
                html = render_to_string(template: "transactions/summary.pdf.erb") 
                pdf = WickedPdf.new.pdf_from_string(html) 
                # send_data(pdf, 
                #   :filename    => "report_#{@verification_stub.name.gsub(/\s+/, "")}_#{@verification_stub.hallticket_no}.pdf", 
                #   :disposition => 'attachment') 
                UserMailer.tickets_purchased(current_user,pdf).deliver_now
                # render  pdf: "report_#{@verification_stub.name.gsub(/\s+/, "")}_#{@verification_stub.hallticket_no}", 
                #         template: "college_verification/report.html.erb"
              end
            end

            #UserMailer.tickets_purchased(current_user).deliver_now
            UserMailer.tickets_sold(seller).deliver_now
                    else
            render nothing: true
            #render 'transactions/paypal_redirect'
        end
        @ticket_i=Ticket.new
        @purchase_history=Transaction.where(:user_id => @user).where.not(:transaction_id => nil)
    end

    def user_transactions
        @user = params[:user_id]    
        @purchase_history=Transaction.where(:user_id => @user).where.not(:transaction_id => nil)
        render 'transactions/paypal_redirect'
    end

    
 
 private
    # Use callbacks to share common setup or constraints between actions.
    def set_transactions
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transactions_params
    params.require(:transaction).permit(:user_id, :ticket_id, :expires_on, :purchase_amount, :number_of_tickets, :ticket_printed_price, :ticket_number, :booking_id, :published, :event_id, :ticket_selling_price, :sale_amount, :ticket_type, :ticket_created_at, :ticket_updated_at, :purchased, :number_of_tickets_purchased, :notification_params, :status, :transaction_id,:purchased_at, :seller_id)     
    end


end






                                        #   <tbody>
                                        #     <% @tickets.each do |ticket|  %>
                                        #         <tr>
                                        #             <td>
                                        #                 <%= number_to_currency(ticket.ticket_selling_price, :unit => '$') %>
                                        #             </td>
                                        #             <td>
                                        #                 <%if((ticket.number_of_tickets - ticket.number_of_tickets_purchased) == 0)%>
                                        #                   SOLD OUT!
                                        #                     <%else%>
                                        #                   <%= ticket.number_of_tickets - ticket.number_of_tickets_purchased%>
                                        #                 <%end%>
                                        #             </td>
                                        #             <td>
                                        #               <%if((ticket.number_of_tickets - ticket.number_of_tickets_purchased) != 0)%>
                                        #                 <%= form_for(@tickets_q ,:url => {:controller => :cart, :action => :add ,:id=> ticket.id}) do |f| %>
                                        #                     <%= f.select(:number_of_tickets, 1.. (ticket.number_of_tickets - ticket.number_of_tickets_purchased),  :class => "myDropDown") %>
                                                        
                                                           
                                        #                     <!--<%#unless session[:cart]%>-->
                                        #                     <%if((ticket.number_of_tickets - ticket.number_of_tickets_purchased) != 0) %>
                                        #                          <%= f.submit "Buy",:class=>"submit_btn btn btn-mod btn-medium btn-round" %>
                                        #                     <%end%>
                                        #                     <!--<%#end%>-->
                                        #                 <%end%>
                                        #                <%else%>
                                        #                   UNAVAILABLE!
                                        #               <%end%>
                                        #             </td> 
                                        #         </tr>
                                        #     <% end %>
                                        # </tbody>







                                        # <tbody>
                                        #     <% @tickets.each do |ticket|  %>
                                        #         <tr>
                                        #             <td>
                                        #                 <%= number_to_currency(ticket.ticket_selling_price, :unit => '$') %>
                                        #             </td>
                                        #             <td>
                                        #                 <%if(ticket.number_of_tickets - ticket.transactions.sum(:number_of_tickets_purchased) == 0)%>
                                        #                   SOLD OUT!
                                        #                     <%else%>
                                        #                   <%= ticket.number_of_tickets - ticket.transactions.sum(:number_of_tickets_purchased)%>
                                        #                 <%end%>
                                        #             </td>
                                        #             <td>
                                        #               <%if(ticket.number_of_tickets - ticket.transactions.sum(:number_of_tickets_purchased) != 0)%>
                                        #                 <%= form_for(@tickets_q ,:url => {:controller => :cart, :action => :add ,:id=> ticket.id}) do |f| %>
                                        #                     <%= f.select(:number_of_tickets, 1.. ticket.number_of_tickets - ticket.transactions.sum(:number_of_tickets_purchased),  :class => "myDropDown") %>
                                                        
                                                           
                                        #                     <!--<%#unless session[:cart]%>-->
                                        #                     <%if(ticket.number_of_tickets - ticket.transactions.sum(:number_of_tickets_purchased) != 0) %>
                                        #                          <%= f.submit "Buy",:class=>"submit_btn btn btn-mod btn-medium btn-round" %>
                                        #                     <%end%>
                                        #                     <!--<%#end%>-->
                                        #                 <%end%>
                                        #                <%else%>
                                        #                   UNAVAILABLE!
                                        #               <%end%>
                                        #             </td> 
                                        #         </tr>
                                        #     <% end %>
                                        # </tbody>
