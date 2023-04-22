
module Api
  module V1
    class RolesController < ApiController
      def create
       @role =  Role.create!(role_params)
        success( @role, 'Role created!')
      end

      def getall
        @roles = Role.all
        success( @roles, "Roles fetched!")
      end

      def find
        role = Role.find(params[:id])
        success(role, "Role fetched")
      end

      private

      def role_params
        params.permit(
          :title, 
          :description
        )
      end
    end
  end
end

