class User < ApplicationRecord

  default_scope { where(deleted_at: nil)}

  def is_user_deleted?
    deleted_at.present?
  end

  def delete_user
    update(deleted_at: Time.current)
  end

  def restore_user
    update(deleted_at: nil)
  end

  has_secure_password

  # validations
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, uniqueness: true

  validates :password, presence: true, confirmation: true, if: -> { new_record? || password.present? }
  validates :password_confirmation, presence: true, if: -> { new_record? || password.present? }

end
