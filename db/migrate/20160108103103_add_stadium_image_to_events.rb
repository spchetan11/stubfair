class AddStadiumImageToEvents < ActiveRecord::Migration
 def self.up
    change_table :events do |t|
      t.attachment :stadium_image
    end
  end

  def self.down
    remove_attachment :events, :stadium_image
  end
end
