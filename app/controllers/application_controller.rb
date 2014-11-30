class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper :all
  helper_method :current_user_session, :current_user, :at_least_1_project, :select_project

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
  
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
  
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_path
        return false
      end
    end
    
    def require_no_user
      if current_user
        store_location
        #flash[:notice] = "You must be logged out to access this page"
        redirect_to index_project_path
        return false
      end
    end
  
    def store_location
      session[:return_to] = request.original_url
    end
  
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    def at_least_1_project
      if current_user
        if ProjectUserRelationship.where(:user_id => current_user.id).length > 0
          return true
        else
          return false
        end
      else
        return false
      end
    end
    
    def select_project
      if session[:project]
        params[:project_name] = "DeWorm"
        return true
      else
        if current_user.projects.count < 1
          session[:project_name] = "DeWorm"
          redirect_to new_project_path
          return false
        else
          session[:project] = current_user.projects.first
          session[:project_name] = session[:project].name
          return true
        end
      end
    end
end
