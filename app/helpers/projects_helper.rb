module ProjectsHelper
  def is_admin_or_project_member?(project)
    current_user.is_admin || current_user.in?(project.users)
  end
end
