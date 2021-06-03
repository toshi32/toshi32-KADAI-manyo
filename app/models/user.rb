class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 50 },
              format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  enum admin: { 一般: false, 管理者: true }
  before_destroy :ensure_has_admin
  private
  def ensure_has_admin
    if User.where(admin: true).count == 1 && self.admin == "管理者"
      throw(:abort)
    end
  end
end
