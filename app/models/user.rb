class User < ActiveRecord::Base
  has_many :charts
  has_many :entries
  
  # Get the Days Since Last Entry by this User
  def get_days_last_use
    days_last_use = -1
    
    # Get all entries from this user
    user_entries = Entry.find( :all, :conditions => ["userid = #{id}"], :order => "id desc" )
      
    if !user_entries.empty?
      timestart = user_entries[0][:created_at]
      timenow = Time.now
      
      dseconds = timenow.to_i - timestart.to_i
      days_last_use = dseconds / ( 60 * 60 * 24 )
    end
  
    return days_last_use
  end
  
  # Get Number of Hours Writing
  def get_writing_stats
    
    # Initialize Hash
    stats_seven_days = { "total" => 0, "editing" => 0, "writing" => 0, "words" => 0 }
    stats_thirty_days = { "total" => 0, "editing" => 0, "writing" => 0, "words" => 0 }
    stats_all_time = { "total" => 0, "editing" => 0, "writing" => 0, "words" => 0 }
    writing_stats = { "seven_days" => stats_seven_days, "thirty_days" => stats_thirty_days, "all_time" => stats_all_time }
      
    # Get all entries from this user
    user_entries = Entry.find( :all, :conditions => ["userid = #{id}"] )
    
    # Loop through entries and increment totals  
    user_entries.each do |entry|
      
      # Get number of days since entry
      d_days = ( Time.now - entry.created_at ) / ( 60 * 60 * 24 )
       
      # Add if within last seven days
      if( d_days < 7 )
        writing_stats[ "seven_days" ][ "words" ] += entry.words
        writing_stats[ "seven_days" ][ "total" ] += entry.hours
        if entry.editing
          writing_stats[ "seven_days" ][ "editing" ] += entry.hours
        else
          writing_stats[ "seven_days" ][ "writing" ] += entry.hours
        end  
      end
      
      # Add if within last thirty days
      if( d_days < 30 )
        writing_stats[ "thirty_days" ][ "words" ] += entry.words
        writing_stats[ "thirty_days" ][ "total" ] += entry.hours
        if entry.editing
          writing_stats[ "thirty_days" ][ "editing" ] += entry.hours
        else
          writing_stats[ "thirty_days" ][ "writing" ] += entry.hours
        end  
      end      
      
      # Add to All-Time
      writing_stats[ "all_time" ][ "words" ] += entry.words
      writing_stats[ "all_time" ][ "total" ] += entry.hours
      if entry.editing
        writing_stats[ "all_time" ][ "editing" ] += entry.hours
      else
        writing_stats[ "all_time" ][ "writing" ] += entry.hours
      end
      
    end 
    
    return writing_stats  
  end
  
end
