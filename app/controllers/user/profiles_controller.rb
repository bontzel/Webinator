class User::ProfilesController < ApplicationController
  def index
    if current_user
      if current_user.wall
        # @posts = current_user.wall.posts.all
        redirect_to user_path(current_user)
      else
        Wall.create(:user_id => current_user.id)
      end
    else
     redirect_to new_user_session_path, notice: 'You are not logged in.'
    end
  end
end
