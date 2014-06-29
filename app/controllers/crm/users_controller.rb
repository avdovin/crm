class Crm::UsersController < ApplicationController
  before_action :set_crm_user, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /crm/users
  def index
    respond_to do |format|
      format.html
      format.js do

        WillPaginate.per_page = params[:limit].blank? ? 1000000 : params[:limit].to_i

        @crm_users = Crm::User
          .search(params[:qsearch])
          .order(sort_column + ' ' + sort_direction)
          .paginate(:page => params[:page] || 1)
      end
    end

  end

  # GET /crm/users/new
  def new
    @crm_user = Crm::User.new
  end

  # GET /crm/users/1/edit
  def edit
  end

  # POST /crm/users
  def create
    @crm_user = Crm::User.new(crm_user_params)

    respond_to do |format|
      if @crm_user.save
        if(!params[:continue].blank?)
          format.html { redirect_to edit_crm_user_path(@crm_user), notice: 'Пользователь создан.' }
          format.json { render :show, status: :created, location: @crm_user }

        else
          format.html { redirect_to crm_users_path, notice: "Пользователь «#{@crm_user.nickname}» создан." }
          format.json { render :show, status: :created, location: @crm_user }
        end

      else
        format.html { render :new }
        format.json { render json: @crm_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crm/users/1
  def update
    respond_to do |format|
      if @crm_user.update(crm_user_params)
        if(!params[:continue].blank?)
          format.html { redirect_to edit_crm_user_path(@crm_user), notice: 'Информация по пользователю обновлена.' }
          format.json { render :show, status: :created, location: @crm_user }

        else
          format.html { redirect_to crm_users_path, notice: "Информация по пользователю «#{@crm_user.nickname}» обновлена." }
          format.json { render :show, status: :created, location: @crm_user }
        end

      else
        format.html { render :edit }
        format.json { render json: @crm_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crm/users/1
  def destroy
    @crm_user.destroy
    redirect_to crm_users_url, notice: 'Пользователь удален.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crm_user
      @crm_user = Crm::User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def crm_user_params
      params.require(:crm_user).permit(:nickname, :email, :password_digest, :password, :password_confirmation)
    end

    def sort_column
      Crm::User.column_names.include?(params[:sort_column]) ? params[:sort_column] : "nickname"
    end

    def sort_direction
      %w[asc desc].include?(params[:sort_direction]) ? params[:sort_direction] : "asc"
    end
end
