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
    if params[:controller] == controller 
			@model = model
			if model.class.name == "Wall"
				if params[:user_id] == model.walled_id.to_s
						return "nav-bar-link-active"
				end
			elsif model.class.name == "Group"
        return "nav-bar-link-active"
      else
				if params[:user_id] == model.user_id.to_s
						return "nav-bar-link-active"
				end
			end
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
    if current_user
      @friendships = Friendship.where("friend_id = ? and pending = ?", current_user.id, true)
      return @friendships
    end
  end

  def  get_notifications
    if current_user
      @nots = Notification.where("user_id = ?", current_user.id)
      return @nots
    end
  end

  def read_requests
    @new_requests = Friendship.where("friend_id = ? and pending = ? and read = ?", current_user.id, true, false)
    if @new_requests
      @reqs_count = @new_requests.count
    end
    if @new_requests.count > 0
      @new_requests.update_all(:read => true)
    end
  end

  def read_notifications
    @new_notifications = Notification.where("user_id = ? and seen = ?", current_user.id, false)
    if @new_notifications
      @nots_count = @new_notifications.count
    end
    if @new_notifications.count > 0
      @new_notifications.update_all(:seen => true)
    end
  end

  def new_notifications
    if current_user
      @new_nots = Notification.where("user_id = ? and seen = ?", current_user.id, false)
      @nots_count = @new_nots.count
      arr = Array.new
      @new_nots.each do |item|
        arr << item.id
      end
      return arr
    end
  end

  def new_requests
    if current_user
      @new_reqs = Friendship.where("friend_id = ? and pending = ? and read = ?", current_user.id, true, false)
      @reqs_count = @new_reqs.count
      arr = Array.new
      @new_reqs.each do |item|
        arr << item.id
      end
      return arr
    end
  end

  def notification_message(number)
    case number
    when 0
      " has liked your comment "

    end

  end

end
