class Post < ApplicationRecord
  belongs_to :admin, optional: true
  validates :title, presence: { message: "Title can't be empty." }
  validates :content, presence: { message: "Content can't be empty." }
  default_scope { order(id: :desc) }
  extend FriendlyId
  friendly_id :yyyy_mm_dd_and_title, use: :slugged

  def yyyy_mm_dd_and_title
    if created_at && title
      "#{created_at.strftime("%Y %m %d")} #{title}"
    end
  end

  def should_generate_new_friendly_id?
    title_changed?
  end

  def previous
    Post.where(["id < ?", id]).first
  end

  def next
    Post.where(["id > ?", id]).last
  end
end
