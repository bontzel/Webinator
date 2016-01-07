module ApplicationHelper
  def is_current_profile
    if current_user && params[:controller] == :profiles
       (params[:id] == current_user.profile.id.to_s) ||
       current_user.profile.nil?
        return true
    end

    return false;
  end

  def get_active_link(controller, model)
    if params[:controller] == controller &&
       params[:user_id] == model.user_id.to_s
       return "nav-bar-link-active"
    end

    return ""
  end

  def is_link_available(attribute)
    if current_user.nil? || current_user.send(attribute).blank?
      return false
    else
      return true
    end
  end

  def  pending_friend_requests
    @friendships = Friendship.where("friend_id = ? and pending = ?", u.id, true)
    
    return
  end
end
