class Crm::DomainsController < ApplicationController
  before_action :set_crm_domain, only: [:show, :edit, :update, :destroy]

  # GET /crm/domains
  # GET /crm/domains.json
  def index
    @crm_domains = Crm::Domain.all
  end

  # GET /crm/domains/1
  # GET /crm/domains/1.json
  def show
  end

  # GET /crm/domains/new
  def new
    @crm_domain = Crm::Domain.new
  end

  # GET /crm/domains/1/edit
  def edit
  end

  # POST /crm/domains
  # POST /crm/domains.json
  def create
    @crm_domain = Crm::Domain.new(crm_domain_params)

    respond_to do |format|
      if @crm_domain.save
        format.html { redirect_to @crm_domain, notice: 'Domain was successfully created.' }
        format.json { render :show, status: :created, location: @crm_domain }
      else
        format.html { render :new }
        format.json { render json: @crm_domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crm/domains/1
  # PATCH/PUT /crm/domains/1.json
  def update
    respond_to do |format|
      if @crm_domain.update(crm_domain_params)
        format.html { redirect_to @crm_domain, notice: 'Domain was successfully updated.' }
        format.json { render :show, status: :ok, location: @crm_domain }
      else
        format.html { render :edit }
        format.json { render json: @crm_domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crm/domains/1
  # DELETE /crm/domains/1.json
  def destroy
    @crm_domain.destroy
    respond_to do |format|
      format.html { redirect_to crm_domains_url, notice: 'Domain was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crm_domain
      @crm_domain = Crm::Domain.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crm_domain_params
      params[:crm_domain]
    end
end
