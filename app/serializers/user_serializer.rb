class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :created_at, :phone_number, :phone_verified, :email_verified,
    :active, :roles

    attribute :roles do |object, params|
      RoleSerializer.new(object.roles).serializable_hash[:data]
    end
end