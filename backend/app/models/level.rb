class Level < ApplicationRecord

  default_scope { where(deleted_at: nil) }
  
  def delete_level
    update(deleted_at: Time.current)
  end

  def level_deleted?
    deleted_at.present?
  end

  def restore_level
    update(deleted_at: nil)
  end

  belongs_to :stream

  before_save :generate_slug

  # validations
  validates :name, presence: true, uniqueness: { scope: :stream_id }

  private
  def generate_slug
    self.slug = "#{name}#{stream.name}".parameterize if name.present? && stream.present?
  end
end
