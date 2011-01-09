class DeveloperNotesController < ApplicationController
  # GET /developer_notes
  # GET /developer_notes.xml
  def index
    @developer_notes = DeveloperNote.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @developer_notes }
    end
  end

  # GET /developer_notes/1
  # GET /developer_notes/1.xml
  def show
    @developer_note = DeveloperNote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @developer_note }
    end
  end

  # GET /developer_notes/new
  # GET /developer_notes/new.xml
  def new
    @developer_note = DeveloperNote.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @developer_note }
    end
  end

  # GET /developer_notes/1/edit
  def edit
    @developer_note = DeveloperNote.find(params[:id])
  end

  # POST /developer_notes
  # POST /developer_notes.xml
  def create
    @developer_note = DeveloperNote.new(params[:developer_note])

    respond_to do |format|
      if @developer_note.save
        format.html { redirect_to(@developer_note, :notice => 'Developer note was successfully created.') }
        format.xml  { render :xml => @developer_note, :status => :created, :location => @developer_note }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @developer_note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /developer_notes/1
  # PUT /developer_notes/1.xml
  def update
    @developer_note = DeveloperNote.find(params[:id])

    respond_to do |format|
      if @developer_note.update_attributes(params[:developer_note])
        format.html { redirect_to(@developer_note, :notice => 'Developer note was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @developer_note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /developer_notes/1
  # DELETE /developer_notes/1.xml
  def destroy
    @developer_note = DeveloperNote.find(params[:id])
    @developer_note.destroy

    respond_to do |format|
      format.html { redirect_to(developer_notes_url) }
      format.xml  { head :ok }
    end
  end
end
