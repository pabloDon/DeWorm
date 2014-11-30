class UserSession < Authlogic::Session::Base
  before_destroy :reset_persistence_token
  before_create  :reset_persistence_token
  
  private 
  def reset_persistence_token
      record.reset_persistence_token
  end
end
