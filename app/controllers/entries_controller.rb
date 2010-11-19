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
    puts params[:hours]
    puts params[:words]
    puts params[:comment]
  
    @entry = Entry.new
    @entry[:comments] = params[:comment]
    @entry[:words] = params[:words]
    @entry[:hours] = params[:hours]
    @entry[:starttime] = DateTime.now
    @entry[:endtime] = DateTime.now
    @entry[:user] = session[:user_id]
    @entry.save
    
    puts @entry.inspect
    
    redirect_to :controller => "users", :action => "home"
  end
end
