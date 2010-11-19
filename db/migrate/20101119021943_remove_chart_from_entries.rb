class RemoveChartFromEntries < ActiveRecord::Migration
  def self.up
    remove_column :entries, :chart
  end

  def self.down
    add_column :entries, :chart, :Chart
  end
end
