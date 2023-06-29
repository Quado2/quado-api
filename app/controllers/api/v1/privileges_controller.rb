module Api
  module V1
    class PrivilegesController < ApiController
      before_action :set_privilege, only: %i[ show update destroy ]

      # GET /privileges
      def index
        @privileges = Privilege.all
        json_response(message: "Privileges fetched !", object: json_serialize(PrivilegeSerializer, @privileges))
      end

      # GET /privileges/1
      def show
        json_response(message: "Privilege fetched !", object: json_serialize(PrivilegeSerializer, @privilege))
      end

      # POST /privileges
      def create
        @privilege = Privilege.new(privilege_params)
        if @privilege.save
          json_response(message: "Privilege created !", object: json_serialize(PrivilegeSerializer, @privilege), status: :created)
        else
          json_response(message: @privilege.errors.full_messages, status: :unprocessable_entity)
        end
      end

      # PATCH/PUT /privileges/1
      def update
        if @privilege.update(privilege_params)
          json_response(message: "Privilege updated !", object: json_serialize(PrivilegeSerializer, @privilege), status: :ok)
        else
          json_response(message: @privilege.errors.full_messages, status: :unprocessable_entity)
        end
      end

      # DELETE /privileges/1
      def destroy
        if @privilege.destroy
          json_response(message: "Privilege deleted !", status: :ok)
        else
          json_response(message: @privilege.errors.full_messages, status: :unprocessable_entity)
        end
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
