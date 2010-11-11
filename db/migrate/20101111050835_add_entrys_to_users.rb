class AddEntrysToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :timeentries, :Entry
  end

  def self.down
    remove_column :users, :timeentries
  end
end
