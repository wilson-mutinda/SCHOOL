class Subject < ApplicationRecord

  default_scope { where(deleted_at: nil)}

  def is_subject_deleted?
    deleted_at.present?
  end

  def delete_subject
    update(deleted_at: Time.current)
  end

  def restore_subject
    update(deleted_at: nil)
  end

  before_save :generate_slug

  # validations
  validates :name, presence: true, uniqueness: true

  private
  def generate_slug
    if name.present?
      self.slug = name.parameterize
    end
  end
end
