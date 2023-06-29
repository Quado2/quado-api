module Serializable
  protected

  def serialize(data, options = {})
    ActiveModelSerializers::SerializableResource.new(data, options)
  end

  def json_serialize(serializer, data)
    serialized = serializer.new(data).serializable_hash[:data]
    return [] unless serialized
    return serialized[:attributes] unless serialized.kind_of?(Array)
    return serialized.map { |mod| mod[:attributes]}
  end
end

