class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :phone, :generated_at, :role

  def generated_at
    object.created_at.strftime("%Y %B, %d")
  end
end
