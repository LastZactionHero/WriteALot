class AddUserToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :user_id, :user
  end

  def self.down
    remove_column :entries, :user_id
  end
end
