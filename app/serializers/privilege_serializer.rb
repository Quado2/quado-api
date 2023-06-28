class PrivilegeSerializer < ActiveModel::Serializer
  attributes :id, :mod_id, :create, :edit, :update, :delete
  has_one :role, has_one :mod
end
