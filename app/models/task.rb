class Task < ApplicationRecord
  validates :title, presence: true, length: { in: 1..100 }
  validates :content, presence: true, length: { in: 1..100 }
  validates :limit, presence: true
  validates :status_name, presence: true
  validates :user_id, presence: true
  scope :search_title, -> (search_title) { where("title LIKE ?", "%#{search_title}%") }
  scope :search_status, -> (search_status) { where(status_name: search_status)}
  enum status_name: { 未着手: 1, 着手: 2, 完了: 3 }
  enum priority: { 低: 1, 中: 2, 高: 3}
  belongs_to :user
end
