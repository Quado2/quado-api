
module Api
  module V1
    class RolesController < ApiController
      def create
        title =  params[:title]
        description = params[:designation]
        p(title)
        Role.create(role_params)
        success({}, 'here we are men')
      end

      private
      def role_params
        params.permit(
          :title, 
          :designation
        )
      end
    end
  end
end

