module Constants
  JWT_ALGORITHM = ENV['JWT_ALGORITHM'],
  JWT_SECRET = ENV['JWT_SECRET']
  JWT_ACCESS_TOKEN_EXPIRY=60.hours
  JWT_REFRESH_TOKEN_EXPIRY=1.month

  METHOD_PRIVILEGE_MAP = {
    'get' => 'can_read',
    'post' => 'can_create',
    'patch' => 'can_edit',
    'put' => 'can_edit',
    'delete' => 'can_delete'
  }
end