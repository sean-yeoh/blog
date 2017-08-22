class Todo < ApplicationRecord
  validates :item, presence: true
end
