class Stream < ApplicationRecord

  has_many :levels


  default_scope { where(deleted_at: nil) }

  def soft_delete
    update(deleted_at: Time.current)
  end

  def soft_deleted?
    deleted_at.present?
  end

  def restore_stream
    update(deleted_at: nil)
  end

  # before_save
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
