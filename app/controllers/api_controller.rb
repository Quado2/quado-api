class ApiController < ActionController::API
  include ApplicationHelper
  include JwtHelpers
  include ApiHelpers
  include Constants
  include Serializable

  include ActionController::HttpAuthentication::Token::ControllerMethods
  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from NameError, with: :general_error
  rescue_from StandardError, with: :general_error

  before_action :throttle_token
  before_action :authenticate
  before_action :is_authorized?



end