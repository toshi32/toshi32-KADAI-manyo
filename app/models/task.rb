class Task < ApplicationRecord
  validates :title, presence: true, length: { in: 1..100 }
  validates :content, presence: true, length: { in: 1..100 }
  validates :limit, presence: true
  validates :status_name, presence: true
  scope :search_title, -> (search_title) { where("title LIKE ?", "%#{search_title}%") }
  scope :search_status, -> (search_status) { where(status_name: search_status)}
  #enum status_list:{ 未着手: 1, 着手: 2, 完了: 3 }
end
