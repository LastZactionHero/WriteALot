class CreateInvitesUsersJoin < ActiveRecord::Migration
  def self.up
    create_table "invites_users_join", :id => false do |t|
      t.column "invite_id", :integer
      t.column "user_id", :integer
    end
  end

  def self.down
    drop_table "invites_user_join"
  end
end
