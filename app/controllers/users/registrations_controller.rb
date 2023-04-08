# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  
  private

  def respond_with(resource, options={})
    if resource.persisted?
   
      render json: {
        sucess: true,
        message: 'Signed up successfully',
        data: resource,
        status:200 
      }
    else
      render json: {
        sucess: false,
        message: resource.errors.full_messages,
        data: resource,
        status: :unprocessable_entity,
      }
    end
  end
 
end
