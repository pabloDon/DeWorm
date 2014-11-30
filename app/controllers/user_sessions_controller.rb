class UserSessionsController < ApplicationController
  layout "no_sidebar"
  before_filter :require_user, :only => [:destroy]
  before_filter :require_no_user, :only => [:new, :create]
  
  def new  
    @user_session = UserSession.new  
  end
  
  def create  
    @user_session = UserSession.new(params[:user_session]) 
    redirection = index_project_path 
    if @user_session.save  
      flash[:notice] = "Successfully logged in."  
      user = User.find @user_session.attempted_record.id
      if user.projects.count < 1
        pur = ProjectUserRelationship.where(:user_id => user.id).length
        if pur < 1
          redirection =  my_profile_path
          session[:project_name] = nil
          session[:project_id] = nil
        elsif pur == 1
          project = ProjectUserRelationship.where(:user_id => user.id)[0].project
          session[:project_name] = project.name
          session[:project_id] = project.id
        else
          session[:project_name] = user.projects.first.name
          session[:project_id] = user.projects.first.id
          user.last_project = session[:project_id]
        end
      elsif user.projects.count == 1
        session[:project_name] = user.projects.first.name
        session[:project_id] = user.projects.first.id
      else
        if user.last_project != nil
          project = Project.find user.last_project
          session[:project_name] = project.name
          session[:project_id] = project.id
        else
          session[:project_name] = user.projects.first.name
          session[:project_id] = user.projects.first.id
          user.last_project = session[:project_id]
          user.save
        end
      end
      redirect_to redirection
    else  
      render :action => 'new'  
    end  
  end
  
  def destroy  
    @user_session = UserSession.find  
    @user_session.destroy  
    flash[:notice] = "See you soon!"  
    reset_session
    redirect_to :root_path
  end
end
