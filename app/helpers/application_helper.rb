module ApplicationHelper
  def json_response(object: {}, message: '',  status: 200, meta: {}, include: [])
    message = [message] if message.class.to_s == "String"
    render json: {
             success: is_success?(status),
             message: message ,
             data: object,
             meta: meta
           }, status: status, include: include
  end

  def is_success?(status)
    %w[2 3].include?(status.to_s[0])
  end

  def success(response_object, message = '')
    json_response(object: response_object, message: message)
  end

  def unprocessable(exception)
    json_response(error: exception.record.errors.full_messages, status: 422)
  end

  def standard_error(exception)
    json_response(error: exception.message, status: 500)
  end

  def not_authorized(message = 'You are not authorized to perform this action')
    json_response(error: message, status: :forbidden)
  end

  def not_authenticated(message = 'You need to login to have Access.')
    json_response(error: message, status: :unauthorized)
  end

  def record_not_found(exception)
    json_response(error: exception.message, status: :not_found)
  end

  def record_not_unique(exception)
    json_response(error: exception.message, status: 409)
  end

  def general_error(exception)
    json_response(message: exception.message, status: 500)
  end

  def render_unauthorized()
    json_response(message: 'You are not authorized to perform this action, log in to perform this action', status: :unauthorized)
  end

  def render_bad_credentials()
    json_response(message: 'Bad Credentials', status: :unauthorized)
  end


end