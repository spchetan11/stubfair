class RemoveTicketAttachmentFromEvents < ActiveRecord::Migration
  def change
  	remove_attachment :events, :ticket_attachment
  end
end
