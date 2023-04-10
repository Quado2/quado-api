class CurrentUserController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: {
      sucess: true,
      message: 'Fetched user successfully',
      data: current_user,
      status: {message: :ok, code: 200} 
      }

  end
end
