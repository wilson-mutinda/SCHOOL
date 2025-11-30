class SubjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :generated_at, :slug

  def generated_at
    object.created_at.strftime("%Y %B, %d")
  end
end
