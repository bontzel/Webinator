class GroupsController < ApplicationController
  respond_to :json

	def index
		@groups = current_user.groups

		groupAux = Array.new
		current_user.tags.each do |tag|
			groupAux += tag.groups
		end

		groupAux2 = groupAux.uniq
		groupAux3 = groupAux2.sort { |a, b| a.users.count <=> b.users.count }
		@recGroups = groupAux3.reverse

    @recGroups.each do |group|
      if Subscription.exists?(:user_id => current_user.id, :group_id => group.id)
        @recGroups.delete(group)
      end
    end

	end

  def new
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.wall.posts
    @hasSubscribed = Subscription.exists?(group_id: params[:id], user_id: current_user.id)

  end

  def create


    @cats = params[:categories]

    @newGroup = Group.new
    @newGroup.title = params[:title]
    @newGroup.description = params[:description]
    @newGroup.admin_id = params[:user_id]
    @newGroup.imageSource = params[:imageSource]
		shortDesc = params[:description].slice(0..10)
		shortDesc = shortDesc + '...'
		@newGroup.short_description = shortDesc

    @cats.each do |cat|
      @newGroup.tags << Tag.find(cat[:id])
    end

    if @newGroup.save
      @newGroup.users << @newGroup.admin
      @newGroup.wall = Wall.create()
      render :json => { :redirect_to => "/groups/" + @newGroup.id.to_s }
    else
      render :json => { :redirect_to => ''}
    end

  end


	def destroy
		@entries = Subscription.where(:group_id => params[:id])
		@entries.find_each do |entry|
			entry.destroy
		end

		GroupsHaveTag.where(:group_id => params[:id]).find_each do |entry|
			entry.destroy
		end

		Group.find(params[:id]).wall.posts.find_each do |post|
      Notification.where(:notifiable_type => 'Post', :notifiable_id => post.id).destroy_all
      post.comments.each do |comment|
        Notification.where(:notifiable_type => 'Comment', :notifiable_id => comment.id).destroy_all
        comment.destroy
      end
		end

		Group.find(params[:id]).wall.posts.destroy_all

		Group.find(params[:id]).wall.destroy

		Group.find(params[:id]).destroy


		redirect_to  user_groups_path(current_user.id)
	end

end
