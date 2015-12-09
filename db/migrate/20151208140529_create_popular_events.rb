class CreatePopularEvents < ActiveRecord::Migration
  def change
    create_table :popular_events do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
