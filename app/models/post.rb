class Post < ApplicationRecord
  belongs_to :admin
  validates :title, :content, presence: true
end
