class Entry < ActiveRecord::Base
  belongs_to :users
  belongs_to :chart
end
