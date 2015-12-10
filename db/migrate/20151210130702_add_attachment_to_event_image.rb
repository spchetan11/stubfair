class AddAttachmentToEventImage < ActiveRecord::Migration
def self.up
    change_table :event_images do |t|
      t.attachment :attachment
    end
  end

  def self.down
    drop_attached_file :event_images, :attachment
  end
end
