class AddHoursToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :hours, :int
  end

  def self.down
    remove_column :entries, :hours
  end
end
