class ApiController < ActionController::API
  include ApplicationHelper
  include Constants
  include Serializable
  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from NameError, with: :general_error


end