class User < ActiveRecord::Base
  has_many :charts
  has_many :entries
  
  # Get the Days Since Last Entry by this User
  def get_days_last_use
    days_last_use = -1
    
    # Get all entries from this user
    user_entries = Entry.find( :all, :conditions => ["userid = #{id}"], :order => "starttime desc" )
      
    if !user_entries.empty?
      timestart = user_entries[0][:starttime]
      timenow = Time.now
      
      dseconds = timenow.to_i - timestart.to_i
      days_last_use = dseconds / ( 60 * 60 * 24 )
    end
  
    return days_last_use
  end
  
  # Get writing stats withing a specific week
  def get_writing_stats_in_week( in_date )
    
    # Initialize Hash
    stats = { "total" => 0, "editing" => 0, "writing" => 0, "words" => 0 }
          
    # Get the current day of week
    dayCurrent = in_date.wday().to_i
    
    # Get date at the start of the week
    timeStart = Time.utc( in_date.year, in_date.month, in_date.day )
    timeStart = timeStart - 24 * 60 * 60 * dayCurrent
    
    # Get date at the end of the week
    timeEnd = Time.utc( in_date.year, in_date.month, in_date.day )
    timeEnd = timeEnd + 24 * 60 * 60 * ( 7 - dayCurrent )
    
    # Loop through entries and increment totals
    user_entries = Entry.find( :all, :conditions => ["userid = #{id}"] )
      
    user_entries.each do |entry|
      if( entry.words.nil? || entry.hours.nil? || entry.minutes.nil? )
        next      
      end
    
      timeEntry = Time.utc( entry.starttime.year, entry.starttime.month, entry.starttime.day, entry.starttime.hour, entry.starttime.min )
      
      if( timeStart.to_i <= timeEntry.to_i && timeEnd.to_i >= timeEntry.to_i )
        stats[ "words" ] += entry.words
        stats[ "total" ] += entry.hours + entry.minutes.to_f / 60
        if entry.editing
          stats[ "editing" ] += entry.hours + entry.minutes.to_f / 60
        else
          stats[ "writing" ] += entry.hours + entry.minutes.to_f / 60
        end 
      end
    end
    
    return stats
    
  end
  
  # Get writing stats for entries within a period of time
  def get_writing_stats_since( in_days_ago )
    get_writing_stats_in_week( DateTime.now )
    
    # Initialize Hash
    stats = { "total" => 0, "editing" => 0, "writing" => 0, "words" => 0 }    
      
    # Get all entries from this user
    user_entries = Entry.find( :all, :conditions => ["userid = #{id}"] )
      
    # Loop through entries and increment totals  
    user_entries.each do |entry|
      
      if( entry.words.nil? || entry.hours.nil? || entry.minutes.nil? )
        next  
      end
      
      # Get number of days since entry
      d_days = ( Time.now - entry.starttime ) / ( 60 * 60 * 24 )
       
      # Add if within last seven days
      if( d_days < in_days_ago || in_days_ago == -1 )
        stats[ "words" ] += entry.words
        stats[ "total" ] += entry.hours + entry.minutes.to_f / 60
        if entry.editing
          stats[ "editing" ] += entry.hours + entry.minutes.to_f / 60
        else
          stats[ "writing" ] += entry.hours + entry.minutes.to_f / 60
        end  
      end
    end  
    
    return stats    
  end
  
  # Get Number of Hours Writing
  def get_writing_stats
    
    # Initialize Hash
    stats_seven_days = { "total" => 0, "editing" => 0, "writing" => 0, "words" => 0 }
    stats_thirty_days = { "total" => 0, "editing" => 0, "writing" => 0, "words" => 0 }
    stats_all_time = { "total" => 0, "editing" => 0, "writing" => 0, "words" => 0 }
    stats_this_week = { "total" => 0, "editing" => 0, "writing" => 0, "words" => 0 }
    writing_stats = { "seven_days" => stats_seven_days, "thirty_days" => stats_thirty_days, "all_time" => stats_all_time, "this_week" => stats_this_week }
      
    # Get all entries from this user
    user_entries = Entry.find( :all, :conditions => ["userid = #{id}"] )
    
    # Get Week Stats
    stats_week = get_writing_stats_in_week( DateTime.now )
    writing_stats["this_week"] = stats_week
      
    # Get 7-Day Stats
    stats_seven = get_writing_stats_since( 7 )
    writing_stats["seven_days"] = stats_seven

    # Get 30-Day Stats
    stats_thirty = get_writing_stats_since( 30 )
    writing_stats["thirty_days"] = stats_thirty
    
    # Get All-Time Stats
    stats_alltime = get_writing_stats_since( -1 )
    writing_stats["all_time"] = stats_alltime      
    
    return writing_stats  
  end
  

  # Get Words Every Week Data String
  def get_data_words_every_week
    words_per_day = Array.new( 7, 0 )
        
    # Loop through entries and increment totals
    user_entries = Entry.find( :all, :conditions => ["userid = #{id}"] )
      
    user_entries.each do |entry|
      if( entry.words.nil? || entry.hours.nil? || entry.minutes.nil? )
        next      
      end
    
      dayEntry = entry.starttime.wday().to_i

      words_per_day[dayEntry] += entry.words
    end
    
    # Assemble Data String
    data_string = ""
    
    (0..(words_per_day.length - 1)).each do |i|
      data_string = data_string + words_per_day[i].to_s
      if( i < words_per_day.length - 1 )
        data_string = data_string + ","
      end
    end
    
    return data_string
  end
    
  
  # Get Words this Week Data String
  def get_data_words_this_week
    words_per_day = Array.new( 7, 0 )
    
    # Get the current day of week
    dateCurrent = DateTime.now
    dayCurrent = dateCurrent.wday().to_i
    
    # Get date at the start of the week
    timeStart = Time.utc( dateCurrent.year, dateCurrent.month, dateCurrent.day )
    timeStart = timeStart - 24 * 60 * 60 * dayCurrent
    
    # Get date at the end of the week
    timeEnd = Time.utc( dateCurrent.year, dateCurrent.month, dateCurrent.day )
    timeEnd = timeEnd + 24 * 60 * 60 * ( 7 - dayCurrent )
    
    # Loop through entries and increment totals
    user_entries = Entry.find( :all, :conditions => ["userid = #{id}"] )
      
    user_entries.each do |entry|
      if( entry.words.nil? || entry.hours.nil? || entry.minutes.nil? )
        next      
      end
    
      dayEntry = entry.starttime.wday().to_i
      timeEntry = Time.utc( entry.starttime.year, entry.starttime.month, entry.starttime.day, entry.starttime.hour, entry.starttime.min )
      
      if( timeStart.to_i <= timeEntry.to_i && timeEnd.to_i >= timeEntry.to_i )
        words_per_day[dayEntry] += entry.words
      end
    end
    
    # Assemble Data String
    data_string = ""
    
    (0..(words_per_day.length - 1)).each do |i|
      data_string = data_string + words_per_day[i].to_s
      if( i < words_per_day.length - 1 )
        data_string = data_string + ","
      end
    end
    
    return data_string
  end

# Get Words Each Week Data String
def get_data_words_each_week
  
  # Get Current Year
  yearCurrent = Time.now.year
  
  # One entry for each week of the year
  words_per_week = Array.new( 52, 0 )
    
  # Loop through entries and increment totals
  user_entries = Entry.find( :all, :conditions => ["userid = #{id}"] )
    
  user_entries.each do |entry|
    if( entry.words.nil? || entry.hours.nil? || entry.minutes.nil? )
      next      
    end
  
    if( yearCurrent != entry.starttime.year )
      next
    end
      
    week = entry.starttime.strftime( "%W" ).to_i
    puts "Week: #{week}  Time: #{entry.starttime}"
  
    words_per_week[week] = words_per_week[week] + entry.words
  end
  
  # Assemble Data String
  data_string = ""
  
  (0..(words_per_week.length - 1)).each do |i|
    data_string = data_string + words_per_week[i].to_s
    if( i < words_per_week.length - 1 )
      data_string = data_string + ","
    end
  end
  
  puts data_string
  return data_string
end
      
end
