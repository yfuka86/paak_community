class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_options, only: [:new, :edit, :create, :update]
  before_action :authenticate_member!, only: [:edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    @project.users << current_user
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: 'Project was successfully created.' and return
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.' and return
    else
      params['project']['user_projects_attributes'].each{|i, p| p['_destroy'] = false}
      render :edit
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    if @project.destroy
      redirect_to projects_url, notice: 'Project was successfully destroyed.' and return
    else
      render :back
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    def set_options
      @periods = current_user.periods
      @users = User.candidate
    end

    def authenticate_member!
      unless current_user.is_admin || current_user.in?(@project.users)
        redirece_to :back, notice: '権限がありません' and return
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :period_id, :url, :summary, user_projects_attributes: [:id, :user_id, :_destroy])
    end
end
