class WallsController < ApplicationController
  def show
    @wall = Wall.find(params[:id])
    @posts = @wall.posts
    @post = Post.new


    @popularUsers = Array.new
    @relevantPopularUsers = Array.new

    UserPopularity.all.each do |upentry|
      @popularUsers.push(upentry.user)
    end



    @popularUsers.each do |user|
      if Friendship.where(:user_id => current_user.id, :friend_id => user.id, :accepted => true).empty?
        if Friendship.where(:user_id => user.id, :friend_id => current_user.id, :accepted => true).empty?
          if current_user.id != user.id
            @relevantPopularUsers.push(user)
          end
        end
      end
    end

    @relevantPopularUsers = @relevantPopularUsers.sort_by { |e| e.likers_count.to_i }
    @relevantPopularUsers = @relevantPopularUsers.reverse
    @relevantPopularUsers = @relevantPopularUsers.first(5)


  end
end
