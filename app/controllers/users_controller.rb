require 'cgi'

class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  # LOGIN /users/login
  def login
    # If already logged in, forward to the Twitter login process
    if session[:user_name] && !session[:user_name].empty?
      redirect_to :action => "proc_twitter_login"
    end
  end
 
  # LOGIN_BROWSERSTATS /users/login_browserstats
  # Records any necessary browser stats after the index page
  # prior to Twitter login
  def login_browserstats
    session[:timezone_offset] = params[:timezone_offset].to_i
    mode = params[:mode]
    
    #puts "Timezone Offset: #{session[:timezone_offset]}"
      
    if( mode == "facebook" )
      redirect_to( "/auth/facebook" )    
    else
      redirect_to( "/auth/twitter" )
    end
  end
  
  # Process Twitter Login Success
  def proc_twitter_login
     
    # If user is already logged in, grab session variables
    if session[:user_name] && !session[:user_name].empty?
      @real_name = session[:real_name] 
      @user_name = session[:user_name]
      @user_image = session[:user_image]       
    else
    # If user is not logged in, grab authentication varaibles
      @real_name = request.env['rack.auth']['user_info']['name']
      @user_name = request.env['rack.auth']['user_info']['nickname']
      @user_image = request.env['rack.auth']['user_info']['image']
        
      session[:user_name] = @user_name
      session[:real_name] = @real_name
      session[:user_image] = @user_image     
    end
       
    @exists = false
    @user_id = -1
    
    puts "Checking if user already exists in database..."
    
    # Check if user already exists in database
    User.all.each do |user|
      if user[:twitter] == @user_name
        @exists = true
        @user_id = user.id
        session[:user_id] = @user_id
      break;
      end
    end
    
    # User does not exist in database. Add new user
    if !@exists
      new_user = User.new( :twitter => @user_name, :name => @real_name )
      new_user.save
      
      @user_id = new_user.id
      session[:user_id] = @user_id
    end

    # Redirect to the user home page
    redirect_to :action => "home"    
  end
    
  # Process Facebook Login Success
  def proc_facebook_login
       
    puts "proc_facebook_login"
      
     puts request.env['rack.auth'].inspect
     
         
     # If user is already logged in, grab session variables
     if session[:user_name] && !session[:user_name].empty?
       @real_name = session[:real_name] 
       @user_name = session[:user_name]
       @user_image = session[:user_image]       
     else
      # If user is not logged in, grab authentication varaibles
       @real_name = request.env['rack.auth']['user_info']['name']
       @user_name = request.env['rack.auth']['user_info']['name']
       #@user_image = request.env['rack.auth']['user_info']['image']
       @user_image = ""
         
       session[:user_name] = @user_name
       session[:real_name] = @real_name
       session[:user_image] = @user_image     
      end
         
      @exists = false
      @user_id = -1
      
      #puts "Checking if user already exists in database..."
      
      # Check if user already exists in database
      User.all.each do |user|
        if user[:twitter] == @user_name
          @exists = true
          @user_id = user.id
          session[:user_id] = @user_id
        break;
        end
      end
      
      # User does not exist in database. Add new user
      if !@exists
        new_user = User.new( :twitter => @user_name, :name => @real_name )
        new_user.save
        
        @user_id = new_user.id
        session[:user_id] = @user_id
      end
      
    # Redirect to the user home page
    redirect_to :action => "home"
  end

  # User Home Page
  def home
    # Starting Tab
    @tab = params[:tab];
    
    # Get info for the current user
    @user_id = session[:user_id]
    @user_name = session[:user_name]
    @user_image = session[:user_image]
    @real_name = session[:real_name]
    
    # If information is missing, redirect to log in
    if @user_id.nil?
      redirect_to :action => "login"
    end
    
    # Get all entries for this user
    @user_entries = Entry.find( :all, :conditions => ["userid = #{session[:user_id]}"], :order => "starttime desc" )
    @user = User.find( @user_id )
      
    # Get the days since last entry
    @days_last_use = @user.get_days_last_use
    
    # Get writing stats
    @writing_stats = @user.get_writing_stats
    
    # Get Invitations
    @invites = Invite.find( :all, :conditions => [ "host_user = #{session[:user_id].to_i}" ] )
    
    @invites_pending = Array.new
    @invites_target = Invite.find( :all, :conditions => [ "target_user = #{session[:user_id]}" ] )
    @invites_target.each do |pending|
      if( !pending.accepted )
        @invites_pending.push( pending )
      end
    end
   
    # New Invitations
    @possible_friends = @user.get_friends_of_friends( 2 )
    
    # Alert Messaging
    @message = "";
    if( params[:message] )
      case params[:message]
        when "e_user_not_found": @message = "The requested user was not found."
        when "e_server_error": @message = "Unknown server error"
        when "e_invite_exists": @message = "You are already friends with this user."
        when "e_invite_self": @message = "You cannot invite yourself."  
      end
    end
    
    # Developer Notes
    @devnotes = DeveloperNote.find( :all, :order => "created_at desc" )
    
    
    
    # Social Graphs
    puts "Invitations:"
    @user.invites.find( :all, :conditions => { :host_user => @user.id } ).each do |invite|
      puts invite.inspect
      puts "This week:  #{invite.users[0].get_data_words_this_week}"
      puts "Every week: #{invite.users[0].get_data_words_every_week}"
      puts "All year:   #{invite.users[0].get_data_words_each_week}"

    end
    
  end
  
  def signout
    session[:user_id] = ""
    session[:user_name] = ""
    session[:user_image] = ""
    session[:real_name] = ""
      
    # Redirect to the user home page
    redirect_to "/"
  end
  
  def become
    session[:user_id] = params[:id]
    session[:user_name] = params[:twitter]
    session[:real_name] = params[:name]
    puts "User ID: #{session[:user_id]}"  
      
    redirect_to :action => "home"
  end
  
  
  # Add Invitation
  # invite_add
  def invite_add
    puts "invite_add:"
    
    fail = false
    
    username = params[:username] 
    username = username.sub( "%20", " " )
    
    # Find the Target User
    #target_user = User.find( :first, :conditions => { :twitter => username  } )
    target_user = nil
    User.all.each do |t|
      if( t.twitter.downcase == username.downcase )
        target_user = t
        break
      end
    end
    if( target_user.nil? )
      redirect_to :action => "home", :tab => "social", :message => "e_user_not_found"
      fail = true
    end
      
    # Find the Host User
    host_user = User.find( session[:user_id].to_i )
    if( host_user.nil? )
      redirect_to :action => "home", :tab => "social", :message => "e_server_error"
      fail = true
    end
    
    # Make sure the user isn't inviting themselves
    if( !fail )
      if( host_user.id == target_user.id )
        redirect_to :action => "home", :tab => "social", :message => "e_invite_self"
        fail = true
      end
    end
    
    # Check to see if this invitation already exists
    if( !fail )
      existing_invite = host_user.invites.find( :first,:conditions => { :target_user => target_user.id } )      
      if( existing_invite )
        redirect_to :action => "home", :tab => "social", :message => "e_invite_exists"
        fail = true
      end
    end
    
    
    # Create a New Invitation
    if( !fail )
      invite = Invite.new
      invite.accepted = false
      invite.active = true
      invite.target_user = target_user.id
      invite.host_user = host_user.id
      #invite.users << target_user
      #invite.users << host_user
      
      #invite.users[0] = target_user
      #invite.users[1] = host_user
      
      invite.save
      
      #host_user.invites << invite
      host_user.save
      
      redirect_to :action => "home", :tab => "social"
    end

  end

  # Ignore Invitation
  # invite_ignore
  def invite_ignore
    
    # Fetch the invitation
    invite_id = params[:id]
    invite = Invite.find( invite_id )
    
    # Make sure user has permission to ignore invitation
    if( invite.target_user == session[:user_id].to_i )
      invite.destroy
    end
    
    redirect_to :action => "home", :tab => "social"
  end
  
  # Accept Invitation
  def invite_accept
    
    # Fetch invitation
    invite_id = params[:id].to_i
    invite = Invite.find( invite_id )
      
    # Make sure user has permission to accept invitation
    if( invite.target_user == session[:user_id].to_i )
      
      # Mark invitation as accepted
      invite.accepted = true
      invite.save
      
      # Create new invitation in opposite direction
      invite_new = Invite.new
      invite_new.accepted = true
      invite_new.active = true
      invite_new.host_user = invite.target_user
      invite_new.target_user = invite.host_user
      #invite_new.users << User.find( invite.host_user )
      #invite_new.users << User.find( invite.target_user )
      #invite_new.users << invite.users[1]
      #invite_new.users << invite.users[0]
      
      #invite_new.users[0] = invite.users[1]
      #invite_new.users[1] = invite.users[0]
      
      invite_new.save
      
      #host_user = User.find( session[:user_id].to_i )
      #host_user.invites << invite_new
      #host_user.save
      
    end
    
    redirect_to :action => "home", :tab => "social"
  end
  
  # Delete Invitation
  def invite_delete
    puts "invite_delete"
    
    # Fetch invitation
    invite_id = params[:id].to_i
    puts "removing invite id: #{invite_id}"
    
    invite = Invite.find( invite_id )
    puts invite.inspect
    
    # Make sure user has permission to delete this invitation
    if( invite.host_user == session[:user_id].to_i )
      puts "User has permission to delete"
        
      # Delete invitation
      target_id = -1
      if( invite )
        puts "Invite found."
        target_id = invite.target_user
        puts "Invite is for target user:#{target_id}"
        invite.destroy
        puts "Deleting invitation"
      end
      
      # Delete inviations in opposite direction
      if( target_id >= 0 )
        target_user = User.find( target_id )
        #if( target_user )
          #target_user_invitations = target_user.invites.find( :all, :conditions => [ "target_user = #{session[:user_id].to_i}" ] )
          #target_user_invitations = target_user.invites.find( :all, :conditions => { :target_user => session[:user_id].to_i } )
          target_user_invitations = Invite.find( :all, :conditions => { :target_user => session[:user_id].to_i, :host_user => target_id } )
          target_user_invitations.each do |t|
            t.destroy
          end
        #end
      end  
    end
    
    redirect_to :action => "home", :tab => "social"
  end
  
  
  # Activate/Deactivate Invitation
  def invite_activate
    
    # Get Invitation
    invite_id = params[:id].to_i
    invitation = Invite.find( invite_id )
    
    if( invitation )
      # Make sure user is allowed to toggle activation
      user_id = session[:user_id].to_i
      invitation_user_id = invitation.host_user
      
      if( user_id == invitation_user_id )
        invitation.active = !invitation.active      
        invitation.save  
      end
      
    end
    
    redirect_to :action => "home", :tab => "social"
      
  end
  
end