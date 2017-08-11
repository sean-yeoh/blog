class Post < ApplicationRecord
  belongs_to :admin, optional: true
  validates :title, :content, presence: true
  default_scope { order(id: :desc) }
  extend FriendlyId
  friendly_id :yyyy_mm_dd_and_title, use: :slugged

  def yyyy_mm_dd_and_title
    "#{created_at.strftime("%Y %m %d")} #{title}"
  end

  def should_generate_new_friendly_id?
    title_changed?
  end
end
