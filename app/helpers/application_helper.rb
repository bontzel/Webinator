module ApplicationHelper
  def is_current_profile
    if current_user && params[:controller] == :profiles
       (params[:id] == current_user.profile.id.to_s) ||
       current_user.profile.nil?
        return true
    end

    return false;
  end
end
