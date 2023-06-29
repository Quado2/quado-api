module Api
  module V1
    class PrivilegesController < ApiController
      before_action :set_privilege, only: %i[ show update destroy ]

      # GET /privileges
      def index
        @privileges = Privilege.all
        json_response(message: "Privileges fetched !", object: json_serialize(PrivilegeSerializer, @priviliges))
      end

      # GET /privileges/1
      def show
        render json: @privilege
      end

      # POST /privileges
      def create
        p 'in create privilege'
        @privilege = Privilege.new(privilege_params)
        p "The created privile", @privilege
        if @privilege.save
          render json: @privilege, status: :created
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
          begin
            @privilege = Privilege.find(params[:id])
          rescue => exception
            json_response(message: exception.message, status: :not_found)
          end
         
        end

        # Only allow a list of trusted parameters through.
        def privilege_params
          params.require(:privilege).permit(:role_id, :mod_id, :can_read, :can_create, :can_edit, :can_delete)
        end
    end
  end
end
