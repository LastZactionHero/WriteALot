class AddWordsToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :words, :int
  end

  def self.down
    remove_column :entries, :words
  end
end
