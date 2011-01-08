class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      t.integer :host_user
      t.integer :target_user
      t.boolean :accepted
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :invites
  end
end
