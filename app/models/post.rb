class Post < ApplicationRecord
  belongs_to :admin
  validates :title, presence: { message: "Title can't be empty." }
  validates :content, presence: { message: "Content can't be empty." }
  default_scope { order(id: :desc) }
  extend FriendlyId
  friendly_id :date_and_title, use: :slugged

  def date_and_title
    date = created_at ? created_at.strftime("%Y %m %d") : Time.now.strftime("%Y %m %d")
    if title
        "#{date} #{title}"
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
