class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]
  before_filter :require_user

  # GET /projects/1
  # GET /projects/1.json
  def show
    redirect_to index_project_path
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = nil
    if params[:name]
      @project = Project.new name: params[:name]
    else
      @project = Project.new(project_params)
    end
    @project.user_id = current_user.id

    respond_to do |format|
      if @project.save
        pur = ProjectUserRelationship.new(user_id: current_user.id, project_id: @project.id)
        pur.save
        format.html { redirect_to :back, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def select_project
    @project = Project.find(params[:id])
    session[:project_name] = @project.name
    session[:project_id] = @project.id
    current_user.last_project = @project.id
    current_user.save
    redirect_to :back, notice: 'Project selected'
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def invite_user
    user = User.where :login => params[:login]
    if user.length > 0
      if (ProjectUserRelationship.where(:user_id => user[0].id, project_id: session[:project_id]).length == 0)
        pur = ProjectUserRelationship.new(user_id: user[0].id, project_id: session[:project_id])
        if pur.save
          respond_to do |format|
            format.html { redirect_to :back, notice: 'User successfully invited.' }
          end
        else
          redirect_to :back, notice: 'Invitation fails!'
        end
      else
        redirect_to :back, notice: 'User is in the party!'
      end
    else
      redirect_to :back, notice: 'User does not exist'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name)
    end
end
