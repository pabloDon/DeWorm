class UsersController < ApplicationController
  layout "no_sidebar", only: [:new]
  before_filter :require_no_user, :only => [:new, :create]
  def new  
      @user = User.new  
  end  

  def create  
    @user = User.new(user_params)  
    if @user.save  
      flash[:notice] = "Registration successful."  
      redirect_to index_project_path
    else  
      render :action => 'new'  
    end  
  end

  def edit  
    @user = current_user 
    @projects = ProjectUserRelationship.where(user_id: @user.id ).collect{|relation| relation.project } 
  end  

  def update  
    @user = current_user  
    if @user.update_attributes(user_params)  
      flash[:notice] = "Successfully updated profile."  
      redirect_to root_url  
    else  
      render :action => 'edit'  
    end  
  end
  
  def statistics
    @projects = Project.all
    @bugs_unassigned = Bug.where(assigned_to: nil).order('created_at desc')
    @bugs_4_me = Bug.where(assigned_to: current_user.id).order('created_at desc')
  end
  
  private

  def user_params
    params.require(:user).permit(:login, :password, :password_confirmation)
  end
end
