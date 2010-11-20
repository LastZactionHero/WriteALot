class AddEditingToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :editing, :boolean
  end

  def self.down
    remove_column :entries, :editing
  end
end
