class Bug < ActiveRecord::Base
  has_many :bug_historics, -> { order "created_at DESC" }
  has_many :notes, -> { order "created_at DESC" }
  has_many :attachments
  belongs_to :project
  belongs_to :user
  
  def clean_summary
    self.summary.gsub!(/<\/?[^>]+>/, '')
  end
  
  def clean_description
    self.description.gsub!(/<\/?[^>]+>/, '')
  end
  
  def get_id
    string = "#"
    (8 - self.id.to_s.length).times do |i|
      string +="0"
    end
    string += "" + self.id.to_s
    string
  end
  
  #STATUS VALUES:
  #0 - New
  #1 - Confirmed
  #2 - Assigned
  #3 - In progress
  #4 - Completed
  #5 - Discard
  def get_status
  end
  
  def is_new?
    self.status == 0
  end
  
  def is_confirmed?
    self.status == 1
  end
  
  def is_assigned?
    self.status == 2
  end
  
  def is_in_progress?
    self.status == 3
  end
  
  def is_completed?
    self.status == 4
  end
  
  def is_discard?
    self.status == 5
  end
  
  #RESOLUTION VALUES:
  #0 - Open
  #1 - Fixed
  #2 - Reopened
  #3 - Unable to reproduce
  #4 - Duplicate
  #5 - Closed
  def is_open?
    self.resolution == 0
  end
  
  def is_fixed?
    self.resolution == 1
  end
  
  def is_reopened?
    self.resolution == 2
  end
  
  def is_unable_to_reproduce?
    self.resolution == 3
  end
  
  def is_duplicated?
    self.resolution == 4
  end
  
  def is_closed?
    self.resolution == 5
  end
  
  #PRIORITY VALUES:
  #0 - Low
  #1 - Medium
  #2 - High
  def is_high?
    self.priority == 2
  end
  
  def is_medium?
    self.priority == 1
  end
  
  def is_low?
    self.priority == 0
  end
end
