module Api
  module V1
    class ModsController < ApiController
      before_action :set_mod, only: %i[ show update destroy ]

      # GET /mods
      def index
        @mods = Mod.all

        return json_response(message: "Modules fetched !", object: json_serialize(ModSerializer, @mods))
      end

      # GET /mods/1
      def show
        json_response(message: "Module fetched !", object: json_serialize(ModSerializer, @mod))
      end

      # POST /mods
      def create
        @mod = Mod.new(mod_params)

        if @mod.save
          json_response(message: "Module created !", object: json_serialize(ModSerializer, @mod), status: :created)
        else
          json_response(message: @mod.errors.full_messages, status: :unprocessable_entity)
        end
      end

      # PATCH/PUT /mods/1
      def update
        if @mod.update(mod_params)
          json_response(message: "Module updated !", object: json_serialize(ModSerializer, @mod), status: :ok)
        else
          json_response(message: @mod.errors.full_messages, status: :unprocessable_entity)
        end
      end

      # DELETE /mods/1
      def destroy
        if @mod.destroy
          return json_response(message: "Module deleted !", status: :ok)
        else
          return json_response(message: @mod.errors.full_messages, status: 500)
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_mod
          begin
            @mod = Mod.find(params[:id])
          rescue => exception
            json_response(message: exception.message, status: :not_found)
          end 
        end

        # Only allow a list of trusted parameters through.
        def mod_params
          params.require(:mod).permit(:title, :name)
        end
    end
  end
end
