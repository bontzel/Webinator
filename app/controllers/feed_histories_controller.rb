class FeedHistoriesController < ApplicationController
  def show
    @posts = Array.new
    @posts << current_user.posts
    @friends = Array.new
    current_user.friendships.each do |f|
      if f.accepted?
        @friends << f.friend
      end
    end

    @friends.each do |friend|
      @posts << friend.posts
    end
  end
end
