class AddUserToChart < ActiveRecord::Migration
  def self.up
    add_column :charts, :creator, :user
  end

  def self.down
    remove_column :charts, :creator
  end
end
