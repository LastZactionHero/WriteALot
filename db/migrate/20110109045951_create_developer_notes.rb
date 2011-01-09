class CreateDeveloperNotes < ActiveRecord::Migration
  def self.up
    create_table :developer_notes do |t|
      t.string :author
      t.string :note

      t.timestamps
    end
  end

  def self.down
    drop_table :developer_notes
  end
end
