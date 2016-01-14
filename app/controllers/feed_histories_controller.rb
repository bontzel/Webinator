class FeedHistoriesController < ApplicationController
  def show
    @posts = Array.new
    @posts.concat(current_user.posts.to_ary)
    @friends = Array.new
    current_user.friendships.each do |f|
      if f.accepted?
        @friends << f.friend
      end
    end

    @friends.each do |friend|
      @posts.concat(friend.posts.to_ary)
    end
  end
end
