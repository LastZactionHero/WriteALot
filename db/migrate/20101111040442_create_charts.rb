class CreateCharts < ActiveRecord::Migration
  def self.up
    create_table :charts do |t|
      t.string :name
      t.string :description
      t.date :startdate
      t.date :enddate

      t.timestamps
    end
  end

  def self.down
    drop_table :charts
  end
end
