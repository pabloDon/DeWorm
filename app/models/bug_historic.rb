class BugHistoric < ActiveRecord::Base
  belongs_to :bug
  belongs_to :user
  
  def self.CREATED
    0
  end
  
  def self.SOLVED
    1
  end
  
  def self.MODIFIED
    2
  end
  
  def self.COMMENTED
    3
  end
  
  def self.ATTACHED
    4
  end
  
  def self.last_5
    BugHistoric.all.order("id desc").limit(5)
  end
  
end
