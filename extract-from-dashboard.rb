section "Analytics" do 
        #@sum_of_all_tickets= Ticket.where(:published => true).sum :number_of_tickets
        @sum_of_all_transactions = Transaction.sum :purchase_amount
        @sum_of_todays_transaction = Transaction.where("created_at = :start",:start => Date.today).sum :purchase_amount
        @sum_of_transactions_week = Transaction.where("created_at >= :start AND created_at <= :end", :start =>1.week.ago.to_date,:end =>Date.today).sum :purchase_amount
        #@most_pop_event_t=Ticket.group(:event_id).order('event_id ASC').first #this is for most pop event by tickets
        @most_pop_event_tr=Transaction.group(:event_id).order('event_id ASC').first #this is for most pop event by sales
        #have to comment this out as there are no transactions
        #@most_pop_buf=@most_pop_event_tr.event_id
        #@pop_event_tr=Event.where(:id =>@most_pop_buf).first.title
        @buf=@most_pop_event_t.event_id
        @pop_event_t=Event.where(:id => @buf).first.title
        #div class: "analytics-container", id: "all-tickets" do
        #    span ("Total Number of Tickets on Site :")
        #    span (@sum_of_all_tickets)
        #end
        div class: "analytics-container", id: "all-transactions" do
            span("Total Amount Of Transactions (in USD)")
            span (@sum_of_all_transactions)
        end
        div class: "analytics-container", id: "all-transactions-today" do
            span("Total Amount Of Transactions Today(in USD)")
            span (@sum_of_todays_transaction)
        end
        div class: "analytics-container", id: "all-transactions-week" do
            span("Total Amount Of Transactions Last Week(in USD)")
            span (@sum_of_transactions_week)
        end
        #div class: "analytics-container", id: "most-pop" do
        #    span("Most Popular WRT to tickets is :")
        #    span (@pop_event_t)
        #end
        
    end