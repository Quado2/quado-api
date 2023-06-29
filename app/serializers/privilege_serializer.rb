class PrivilegeSerializer
  include JSONAPI::Serializer
  attributes :id, :mod_id, :role_id, :can_create, :can_edit, :can_read, :can_delete
  has_one :role
  has_one :mod


  attribute :mod do |object, params|
    ModSerializer.new(object.mod).serializable_hash[:data][:attributes]
  end
  attribute :role do |object, params|
    RoleSerializer.new(object.role).serializable_hash[:data][:attributes]
  end
end
