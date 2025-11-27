class LevelSerializer < ActiveModel::Serializer
  attributes :id, :level_name, :stream_name, :generated_at, :slug

  def level_name
    object.name
  end

  def stream_name
    object.stream.name
  end

  def generated_at
    object.created_at.strftime("%d %B, %Y")
  end
end
