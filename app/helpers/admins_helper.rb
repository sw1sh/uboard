module AdminsHelper
  def admin_exists?
    Admin.exists?
  end
end
