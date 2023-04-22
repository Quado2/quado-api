module ApplicationHelper
  def json_response(object: {}, message: '', error: '', status: 200, meta: {}, include: [])
    render json: {
             success: is_success?(status),
             message: is_success?(status) ? message : error,
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
    json_response(error: exception.message, status: 500)
  end
  def render_unauthorized(realm = 'Application')
    headers['WWW-Authenticate'] = %(Token realm="#{realm.gsub(/"/, '')}")
    json_response(error: 'Bad credentials', status: :unauthorized)
  end
end