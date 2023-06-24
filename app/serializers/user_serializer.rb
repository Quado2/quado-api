class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :created_at, :phone_number, :phone_verified, :email_verified,
    :active, :roles

    attribute :roles do |object, params|
      roles = RoleSerializer.new(object.roles).serializable_hash[:data]
      roles.map { |role| role[:attributes]}
    end
end