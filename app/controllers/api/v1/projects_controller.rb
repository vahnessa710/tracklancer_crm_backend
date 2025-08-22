class Api::V1::ProjectsController < ApplicationController
  before_action :set_user
  before_action :set_client
  before_action :set_project, only: [:show, :update, :destroy]

  def index
    @projects = Project.includes(:client).all
    render json: { message: "Projects List", data: @projects.as_json(include: { client: { only: [:name] } }), status: :ok }
  end

  def show
    render json: @project
  end

  def create
    @project = @client.projects.new(project_params)
    if @project.save
      render json: { message: "Project created", data: @project, status: :created }
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render json: { message: "Project updated", data: @project, status: :ok }
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    render json: { message: "Project deleted", status: :ok }
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_client
    @client = @user.clients.find(params[:client_id])
  end

  def set_project
    @project = @client.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :status, :price, :due_date)
  end
end
