class EntriesController < ApplicationController
  # GET /entries
  # GET /entries.xml
  def index
    @entries = Entry.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entries }
    end
  end

  # GET /entries/1
  # GET /entries/1.xml
  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entry }
    end
  end

  # GET /entries/new
  # GET /entries/new.xml
  def new
    @entry = Entry.new
      
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entry }
    end
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.xml
  def create
    @entry = Entry.new(params[:entry])

    puts "Creating Entry"
    

    Chart.find( session[:chart] ) do |chart|
      puts @entry.inspect
      @entry[:chart] = chart[:id]
      puts @entry.inspect
    end
    
    respond_to do |format|
      if @entry.save
        format.html { redirect_to(@entry, :notice => 'Entry was successfully created.') }
        format.xml  { render :xml => @entry, :status => :created, :location => @entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.xml
  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to(@entry, :notice => 'Entry was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.xml
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to(entries_url) }
      format.xml  { head :ok }
    end
  end
  
  # Create Entry entries/createinline
  # Create an entry and return to home
  def createinline
    # Invalid Data Failure
    fail = false;
    
    # Pull data from parameters
    @entry = Entry.new
    @entry[:comments] = params[:comment]
    @entry[:words] = params[:words]
    @entry[:timestart] = Time.now
    @entry[:timeend] = Time.now
    @entry[:editing] = params[:editing]
    
    @entry[:userid] = session[:user_id]  
    if params[:userid]
      @entry[:userid] = params[:userid]
    end

    # Pull start time and end time data from parameters
    start_year = params[:start_year].to_i
    start_month = params[:start_month].to_i
    start_day = params[:start_day].to_i
    start_hour = params[:start_hour].to_i
    start_minute = params[:start_minute].to_i

    end_year = params[:end_year].to_i
    end_month = params[:end_month].to_i
    end_day = params[:end_day].to_i
    end_hour = params[:end_hour].to_i
    end_minute = params[:end_minute].to_i    
    
    # Set start and end dates
    start_datetime = DateTime.new( start_year, start_month, start_day, start_hour, start_minute )
    end_datetime = DateTime.new( end_year, end_month, end_day, end_hour, end_minute )
    @entry[:starttime] = start_datetime
    @entry[:endtime] = end_datetime 
    
    # Calculate number of hours and minutes
    time_difference = end_datetime.to_time - start_datetime.to_time
    hours = 0
    minutes = 0
    
    if( time_difference <= 0 )
      # Negative time failure
      fail = true;
    else
      # Times Ok
      seconds = time_difference.to_i
      @entry[:hours] = seconds / ( 3600 ).to_i
      @entry[:minutes] = ( ( seconds - @entry[:hours] * 3600 ) / 60 ).to_i
    end
      
    # Save if not failed
    if( !fail )
      @entry.save
      puts @entry.inspect
    end
    
    # Forward back to home
    redirect_to :controller => "users", :action => "home"
  end
  
  # Remove Entry entries/removeinline
  # Delete an entry and return to home  
  def removeinline
    puts params[:entry]
    
    entry = Entry.find( params[:entry] )
    entry.destroy
          
    redirect_to :controller => "users", :action => "home"
  end

end
