class AddChartToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :chart, :Chart
  end

  def self.down
    remove_column :entries, :chart
  end
end
