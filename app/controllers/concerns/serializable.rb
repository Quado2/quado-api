module Serializable
  protected

  def serialize(data, options = {})
    ActiveModelSerializers::SerializableResource.new(data, options)
  end
end