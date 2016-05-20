class PostsController < ApplicationController

  def create
      @wall = Wall.find(params[:wall_id])
      Post.create(:text => params[:post][:text], :user_id => current_user.id, :wall_id => @wall.id)

      if @wall.id != current_user.wall.id
        Notification.create(:user_id => @wall.user.id, :actor_id => current_user.id, :notifiable_id => post.id, :notifiable_type => 'Post', :message_type => 1, :seen => false)
      end

      redirect_to :back
  end

  def like
    
    post = Post.find(params[:_json])
    current_user.post_likes << post

    if post.user.id != current_user.id

      Notification.create(:user_id => post.user.id, :actor_id => current_user.id, :notifiable_id => post.id, :notifiable_type => 'Post', :message_type => 0, :seen => false)

      #[WIP]
      if UserFriendsPreference.exist?(:user_id => current_user.id)

        @ufp = UserFriendsPreference.where(:user_id => current_user.id).first
        @str = @ufp.bsearch{ |item| item.start_with?(post.user.id.to_s)}

        if @str.nil?
          @ufp.entries.push(post.user.id.to_s + ":" + "1")
        else
          @res = @str.split(':')
          @ufp.entries.delete(@str)
          @new_str = post.user.id.to_s + ';' + (@res[1].to_i + 1).to_s
          @ufp.entries.push(@new_str)
          @ufp.save
        end
      else
        @ufp = UserFriendsPreference.create(:user_id => current_user.id, :entries => [])
        @ufp.entries.push(post.user.id.to_s + ":" + "1")
        @ufp.save
      end
    end


    respond_to do |format|
      format.json  { render :json => params[:_json] } # don't do msg.to_json
    end
  end

  def show
    @post = Post.find(params[:id])
  end
end
