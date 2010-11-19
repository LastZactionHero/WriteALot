class AddUseridToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :userid, :integer
  end

  def self.down
    remove_column :entries, :userid
  end
end
