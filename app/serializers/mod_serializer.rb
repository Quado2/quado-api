class ModSerializer ModSerializer
  include JSONAPI::Serializer
  p "in The serializer"
  attributes :id, :title, :name
end
