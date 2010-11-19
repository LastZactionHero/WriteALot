class AddTimeendToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :timeend, :time
  end

  def self.down
    remove_column :entries, :timeend
  end
end
