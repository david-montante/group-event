class CreateGroupEvent < ActiveRecord::Migration
  def change
    create_table :group_events do |t|
      t.string    :name
      t.string    :location
      t.date      :start_date
      t.date      :end_date
      t.integer   :duration
      t.boolean   :published, :default => false
      t.boolean   :deleted, :default => false
      
      t.timestamps
    end
  end
end
