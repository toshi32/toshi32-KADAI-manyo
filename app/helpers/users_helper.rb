module UsersHelper
  def admin?
    if logged_in?
      current_user.admin == "管理者"
    end
  end
end
