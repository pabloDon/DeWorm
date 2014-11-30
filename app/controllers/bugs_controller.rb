class BugsController < ApplicationController
  before_action :set_bug, only: [:show, :edit, :update, :destroy]
  before_filter :require_user
  before_filter :at_least_1_project
  before_filter :user_is_member

  # GET /bugs
  # GET /bugs.json
  def index
    redirect_to index_project_path
  end

  # GET /bugs/1
  # GET /bugs/1.json
  def show
    if @bug.project_id != session[:project_id]
      session[:project_id] = @bug.project_id
      session[:project_name] = @bug.project.name
    end
  end

  # GET /bugs/new
  def new
    @bug = Bug.new
  end

  # GET /bugs/1/edit
  def edit
  end

  # POST /bugs
  # POST /bugs.json
  def create
    @bug = Bug.new(bug_params)
    @bug.project_id = session[:project_id]
    @bug.user_id = current_user.id
    @bug.clean_summary
    @bug.clean_description
    @bug.status = 0 #New
    @bug.resolution = 0 #Open

    respond_to do |format|
      if @bug.save
        BugHistoric.create(bug_id: @bug.id, ref: BugHistoric.CREATED, user_id: current_user.id)
        format.html { redirect_to @bug, notice: 'Bug was successfully created.' }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bugs/1
  # PATCH/PUT /bugs/1.json
  def update
    respond_to do |format|
      if @bug.update(bug_params)
        BugHistoric.create(bug_id: @bug.id, ref: BugHistoric.MODIFIED, user_id: current_user.id)
        format.html { redirect_to @bug, notice: 'Bug was successfully updated.' }
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bugs/1
  # DELETE /bugs/1.json
  def destroy
    redirect_to index_project_path
  end
  
  def search_bug
    bugs = Bug.where :id => params[:bug_id].to_i, :project_id => session[:project_id]
    path = not_found_path
    path = bugs[0] if bugs.size == 1
    redirect_to path  
  end
  
  def timeline
    @history = BugHistoric.all.order 'created_at desc'
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_bug
      @bug = Bug.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bug_params
      params.require(:bug).permit(:assigned_to, :reported_by, :project_id, :priority, :severity, :status, :resolution, :version_planned, :version_solved, :summary, :description)
    end
    
    def user_is_member
      pur = ProjectUserRelationship.where(:user_id => current_user.id, :project_id => session[:project_id])
      return true if pur.length == 1
      return false
    end
end
