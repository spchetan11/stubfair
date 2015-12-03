class AddAttachmentToTicketImages < ActiveRecord::Migration
  def self.up
    change_table :ticket_images do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :ticket_images, :image
  end
end
