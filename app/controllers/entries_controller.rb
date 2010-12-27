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
    
#    if session[:chart]
#      puts "Found Session Chart: #{session[:chart]}"
#      chart = Chart.find( session[:chart] )
#        
#      puts chart.inspect
#      puts @entry.inspect
#      @entry[:chart] = chart[:id]
#    end
    
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
  
  def createinline
    fail = false;
    
    puts params[:hours]
    puts params[:words]
    puts params[:comment]
    puts params[:editing]
      
    @entry = Entry.new
    @entry[:comments] = params[:comment]
    @entry[:words] = params[:words]
    @entry[:minutes] = params[:minutes]
    @entry[:hours] = params[:hours]
    @entry[:timestart] = Time.now
    @entry[:timeend] = Time.now
    @entry[:editing] = params[:editing]
    @entry[:userid] = session[:user_id]

    start_year = params[:start_year].to_i
    start_month = params[:start_month].to_i
    start_day = params[:start_day].to_i
    start_hour = params[:start_hour].to_i
    start_minute = params[:start_minute].to_i
    puts "Params: #{params.inspect}"
    puts "Start DateTime: #{start_year} #{start_month} #{start_day} #{start_hour} #{start_minute}"

    end_year = params[:end_year].to_i
    end_month = params[:end_month].to_i
    end_day = params[:end_day].to_i
    end_hour = params[:end_hour].to_i
    end_minute = params[:end_minute].to_i
    puts "End DateTime: #{end_year} #{end_month} #{end_day} #{end_hour} #{end_minute}"
    
    
    start_datetime = DateTime.new( start_year, start_month, start_day, start_hour, start_minute )
    end_datetime = DateTime.new( end_year, end_month, end_day, end_hour, end_minute )
    
    @entry[:starttime] = start_datetime
    @entry[:endtime] = end_datetime 
    
    time_difference = end_datetime.to_time - start_datetime.to_time
    puts "Difference: #{time_difference}"
    hours = 0
    minutes = 0
    if( time_difference <= 0 )
      puts "FAILURE: Negative time"
      fail = true;
    else
      seconds = time_difference.to_i
      hours = seconds / ( 60 * 60 )
      minutes = ( seconds - hours * 60 * 60 ) / 60
      puts "Hours: #{hours} Minutes: #{minutes}"
      @entry[:hours] = hours
      @entry[:minutes] = minutes
    end
      
    if( !fail )
      @entry.save
      puts @entry.inspect
    end
    redirect_to :controller => "users", :action => "home"
  end
  
  def removeinline
    puts params[:entry]
    
    entry = Entry.find( params[:entry] )
    entry.destroy
          
    redirect_to :controller => "users", :action => "home"
  end

end
