class AddAttachmentTicketAttachmentToEvents < ActiveRecord::Migration

  # got this file by running -- rails generate paperclip events ticket_attachment    --   (table name, column name)
  def self.up
    change_table :events do |t|
      t.attachment :ticket_attachment
    end
  end

  def self.down
    remove_attachment :events, :ticket_attachment
  end
end
