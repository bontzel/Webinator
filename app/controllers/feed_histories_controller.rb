class FeedHistoriesController < ApplicationController

  def show

    if params[:selected] == 'Recommended'
      @selected = :Recommended

      @ufp = UserFriendsPreference.where(:user_id => current_user.id).first

      @entries = Array.new

      @ufp.entries.each do |entry|
        @res = entry.split(':')
        @entries.push({ :user_id => @res[0], :score => @res[1]})
      end

      @posts = Array.new
      @posts.concat(current_user.posts.to_ary)
      @friends = Array.new
      current_user.friendships.each do |f|
        if f.accepted?
          @friends << f.friend
        end
      end

      @friends.each do |friend|
        # @friendEntry = @entries.bsearch{|x| x[:user_id].to_i == friend.id}
        @entries.each do |entry|
          if entry[:user_id].to_i == friend.id
            @friendEntry = entry
            break
          end
        end
        if @friendEntry
          @friendPosts = friend.posts.to_ary
          @friendPosts.each do |post|
            post.score = @friendEntry[:score].to_i - (Date.today - post.created_at.to_date).to_i
            if post.score < 0
              post.score = 0
            end
          end
        end
        @posts.concat(@friendPosts)
      end

      @posts = @posts.sort_by { |p1| [p1.score.to_i, p1.created_at] }
      @posts = @posts.reverse

    else
      @selected = 'By Date'

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

      @posts.sort_by{ |post| post.created_at }
    end

  end

  def sort_by_date
    redirect_to url_for(:controller => :feed_histories, :action => :show, :selected => 'By Date')
  end

  def sort_by_recommended
    redirect_to url_for(:controller => :feed_histories, :action => :show, :selected => 'Recommended')
  end


end
