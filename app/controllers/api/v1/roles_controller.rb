
module Api
  module V1
    class RolesController < ApiController

      before_action :set_role, only: %i[find, destroy]

      def create
       @role =  Role.create!(role_params)
        success( json_serialize(RoleSerializer, @role), 'Role created!')
      end

      def index
        @roles = Role.all
        success( json_serialize(RoleSerializer, @roles), "Roles fetched!")
      end

      def find
        success(json_serialize(RoleSerializer, @role), "Role fetched")
      end

      def destroy
        
        if @role.destroy
          return json_response(message: "Role deleted", status: :ok)
        else
          return json_response(message: @role.errors.full_messages, status: 500)
        end
      end

      private

      def set_role
        begin
          @role = Role.find(params[:id])
        rescue => exception
          json_response(message: exception.message, status: :not_found)
        end
      end

      def role_params
        params.permit(
          :title, 
          :description
        )
      end
    end
  end
end

