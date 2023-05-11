class RoleSerializer
  include JSONAPI::Serializer
  attributes :title, :description
  
  attribute :created_date do |object|
    "#{object.title} 1"
  end

end