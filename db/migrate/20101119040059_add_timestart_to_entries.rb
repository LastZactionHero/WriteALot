class AddTimestartToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :timestart, :time
  end

  def self.down
    remove_column :entries, :timestart
  end
end
