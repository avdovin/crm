class Crm::TasksController < ApplicationController
  before_action :set_crm_task, only: [:show, :edit, :update, :destroy]

  # GET /crm/tasks
  # GET /crm/tasks.json
  def index
    @crm_tasks = Crm::Task.all
  end

  # GET /crm/tasks/1
  # GET /crm/tasks/1.json
  def show
  end

  # GET /crm/tasks/new
  def new
    @crm_task = Crm::Task.new
  end

  # GET /crm/tasks/1/edit
  def edit
  end

  # POST /crm/tasks
  # POST /crm/tasks.json
  def create
    @crm_task = Crm::Task.new(crm_task_params)

    respond_to do |format|
      if @crm_task.save
        format.html { redirect_to @crm_task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @crm_task }
      else
        format.html { render :new }
        format.json { render json: @crm_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crm/tasks/1
  # PATCH/PUT /crm/tasks/1.json
  def update
    respond_to do |format|
      if @crm_task.update(crm_task_params)
        format.html { redirect_to @crm_task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @crm_task }
      else
        format.html { render :edit }
        format.json { render json: @crm_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crm/tasks/1
  # DELETE /crm/tasks/1.json
  def destroy
    @crm_task.destroy
    respond_to do |format|
      format.html { redirect_to crm_tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crm_task
      @crm_task = Crm::Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crm_task_params
      params[:crm_task]
    end
end
