class ModsController < ApplicationController
  before_action :set_mod, only: %i[ show update destroy ]

  # GET /mods
  def index
    @mods = Mod.all

    render json: @mods
  end

  # GET /mods/1
  def show
    render json: @mod
  end

  # POST /mods
  def create
    @mod = Mod.new(mod_params)

    if @mod.save
      render json: @mod, status: :created, location: @mod
    else
      render json: @mod.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /mods/1
  def update
    if @mod.update(mod_params)
      render json: @mod
    else
      render json: @mod.errors, status: :unprocessable_entity
    end
  end

  # DELETE /mods/1
  def destroy
    @mod.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mod
      @mod = Mod.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mod_params
      params.require(:mod).permit(:title, :name)
    end
end
