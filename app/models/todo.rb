class Todo < ApplicationRecord
  validates :description, presence: true
  scope :pending, -> { where(done: false) }
  scope :completed, -> { where(done: true).order(done_at: :desc) }
end
