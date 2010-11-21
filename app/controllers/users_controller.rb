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
    if session[:user_name] && !session[:user_name].empty?
      redirect_to :action => "proc_twitter_login"
    end
  end
 
  # Process Twitter Login Success
  def proc_twitter_login
      
    # If user is already logged in, grab session variables
    # THIS CAN LIKELY BE REMOVED
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
    #session[:user_name] = "LastZactionHero"
    #session[:real_name] = "Zach D"
    #session[:user_image] = ""
    #session[:user_id] = 6
        
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
    @user_entries = Entry.find( :all, :conditions => ["userid = #{session[:user_id]}"], :order => "id desc" )
      
    # Get the days since last entry
    @days_last_use = -1
    if !@user_entries.empty?
      user = @user_entries[0]
      timestart = user[:created_at].to_i
      timenow = Time.now
      
      puts "Time End: #{user[:created_at].to_i}"
      dseconds = timenow.to_i - timestart.to_i
      @days_last_use = dseconds / ( 60 * 60 * 24 )
    end
    
    # Count number of hours this week
    @this_week_hours = 0
    @this_week_hours_writing = 0
    @this_week_hours_editing = 0
    @this_week_words = 0
    @arr_this_week_words = [ 0, 0, 0, 0, 0, 0, 0]
    
    @this_month_hours = 0
    @this_month_hours_writing = 0
    @this_month_hours_editing = 0
    @this_month_words = 0
    
    @all_time_hours = 0
    @all_time_words = 0
    @all_time_hours_writing = 0
    @all_time_hours_editing = 0
    
    @user_entries.each do |entry|
      entry_time = entry[:hours] + entry[:minutes].to_f / 60
        
      timestart = entry[:created_at].to_i
      timenow = Time.now.to_i        
      days_entry = (timenow - timestart) / ( 60 * 60 * 24 )
  
      if( days_entry < 7 )
        @this_week_hours += entry_time
        @this_week_words += entry[:words]
        @arr_this_week_words[days_entry] += entry[:words]
        if entry.editing? 
          @this_week_hours_editing += entry_time
        else
          @this_week_hours_writing += entry_time
        end
      end
      
      if( days_entry < 30 )
        @this_month_hours += entry_time
        @this_month_words += entry[:words]
        if entry.editing? 
          @this_month_hours_editing += entry_time
        else
          @this_month_hours_writing += entry_time
        end        
      end
      
      @all_time_hours += entry_time
      @all_time_words += entry[:words]
      if entry.editing? 
        @all_time_hours_editing += entry_time
      else
        @all_time_hours_writing += entry_time
      end 
    end
    
    @graph_words_seven_days = ""
    @graph_words_seven_days_max = 0
    (0..7).each do |i|
      @graph_words_seven_days += @arr_this_week_words[i].to_s
      if i < 6
        @graph_words_seven_days += ","
      end
      
      @graph_words_seven_days_max = @arr_this_week_words[i].to_i>@graph_words_seven_days_max.to_i ? @arr_this_week_words[i] : @graph_words_seven_days_max
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
  
end