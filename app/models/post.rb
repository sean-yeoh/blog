class Post < ApplicationRecord
  belongs_to :admin, optional: true
  validates :title, :content, presence: true
  default_scope { order(id: :desc) }
end
