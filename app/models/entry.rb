class Entry < ActiveRecord::Base
  belongs_to :users
  
  def get_days_last_use
    return 1
  end
end
