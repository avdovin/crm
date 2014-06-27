class Crm::AccessesController < ApplicationController
  before_action :set_crm_access, only: [:show, :edit, :update, :destroy]

  # GET /crm/accesses
  def index
    @crm_accesses = Crm::Access.all
  end

  # GET /crm/accesses/1
  def show
  end

  # GET /crm/accesses/new
  def new
    @crm_access = Crm::Access.new
  end

  # GET /crm/accesses/1/edit
  def edit
  end

  # POST /crm/accesses
  def create
    @crm_access = Crm::Access.new(crm_access_params)

    if @crm_access.save
      redirect_to @crm_access, notice: 'Access was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /crm/accesses/1
  def update
    if @crm_access.update(crm_access_params)
      redirect_to @crm_access, notice: 'Access was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /crm/accesses/1
  def destroy
    @crm_access.destroy
    redirect_to crm_accesses_url, notice: 'Access was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crm_access
      @crm_access = Crm::Access.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def crm_access_params
      params[:crm_access]
    end
end
