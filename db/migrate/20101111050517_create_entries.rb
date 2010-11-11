class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.datetime :starttime
      t.datetime :endtime
      t.string :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
