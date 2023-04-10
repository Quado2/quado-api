# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  respond_to :json

  private

  def respond_with(resource, options={})
    p("Want to print the resource: ", resource);

    p("Resource name: ", resource_name);

    resource2 = warden.authenticate(scope: resource_name)
    p("Second resource: ", resource2)
    render json: {
      sucess: true,
      message: 'Signed in successfully',
      data: resource,
      status: {message: :ok, code: 200} 
    }
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:secret_key_base)).first
    current_user = User.find(jwt_payload['sub'])
    if current_user
      render json: {
        sucess: true,
        message: 'Signed out successfully',
        data: resource,
        status: :ok 
      }
    else
      render json: {
        status:{code: 401, message: :unauthorized},
        sucess: false,
        message: 'User has no session',
        
      }
    end
  end
end
