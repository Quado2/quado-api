class PrivilegesController < ApplicationController
  before_action :set_privilege, only: %i[ show update destroy ]

  # GET /privileges
  def index
    @privileges = Privilege.all

    render json: @privileges
  end

  # GET /privileges/1
  def show
    render json: @privilege
  end

  # POST /privileges
  def create
    @privilege = Privilege.new(privilege_params)

    if @privilege.save
      render json: @privilege, status: :created, location: @privilege
    else
      render json: @privilege.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /privileges/1
  def update
    if @privilege.update(privilege_params)
      render json: @privilege
    else
      render json: @privilege.errors, status: :unprocessable_entity
    end
  end

  # DELETE /privileges/1
  def destroy
    @privilege.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_privilege
      @privilege = Privilege.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def privilege_params
      params.require(:privilege).permit(:role_id, :mod_id, :create, :edit, :update, :delete)
    end
end
