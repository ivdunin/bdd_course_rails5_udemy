class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 4096 }

  default_scope { order(created_at: :desc) }
end
