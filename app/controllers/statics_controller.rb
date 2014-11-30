class StaticsController < ApplicationController
  layout "no_sidebar", only: [:homepage]
  before_filter :at_least_1_project, :only => [:index]
  before_filter :require_user, :only => [:index]
  before_filter :require_no_user, :only => [:homepage]
   
  def homepage
  end

  def index
    @bugs_unassigned = Bug.where(project_id: session[:project_id], assigned_to: nil).order('created_at desc')
    @bugs_4_me = Bug.where(project_id: session[:project_id], assigned_to: current_user.id).order('created_at desc')
    @participants = ProjectUserRelationship.where( :project_id => session[:project_id]).order('created_at desc')
  end
  
  def not_found
  end
  
  private
    
end
