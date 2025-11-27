class StreamSerializer < ActiveModel::Serializer
  attributes :id, :name, :generated_at

  def generated_at
    object.created_at.strftime("%d %B, %Y")
  end
end
