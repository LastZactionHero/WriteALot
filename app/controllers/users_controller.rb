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
    if session[:user_name]
      redirect_to :action => "proc_twitter_login"
    end
  end
 
  # Process Twitter Login Success
  def proc_twitter_login
    
    # If user is already logged in, grab session variables
    # THIS CAN LIKELY BE REMOVED
    if session[:user_name]
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
    
    # Check if user already exists in database
    User.find( @user_name ) do |user|
      @exists = true
      @user_id = user.id
      session[:user_id] = @user_id
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
    # Get info for the current user
    @user_id = session[:user_id]
    @user_name = session[:user_name]
    @user_image = session[:user_image]
    @real_name = session[:real_name]
    
    # If information is missing, redirect to log in
    if @user_id.nil?
      redirect_to :action => "login"
    end
    
    @user_entries = Entry.all
    #@user_entries = Entry.find( :all, :conditions => ["user = #{session[:user_id]}"], :order => "id desc" )
  end
  
end