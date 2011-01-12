class InvitesController < ApplicationController

  def list_all
    puts "Listing All Invitations"
    @invites = Invite.all
  end
  
  def clear_all
    Invite.all.each do |invite|
      invite.destroy
    end
    
    redirect_to :action => "list_all"
  end
end
