class AddUserToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :user, :User
  end

  def self.down
    remove_column :entries, :user
  end
end
