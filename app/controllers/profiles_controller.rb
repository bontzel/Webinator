class ProfilesController < ApplicationController
  helper ApplicationHelper

  def index
    @profile = current_user.profile
    if @profile.blank?
      redirect_to new_user_profile_path(current_user.id)
    end

    if !current_user.profile.nil?
      redirect_to user_profile_path(current_user.id, current_user.profile.id)
    end
  end

  def new

		@tags = Tag.all
		
    if current_user.id == params[:user_id]
      @profile = Profile.new
      flash[:notice] = "K"
    else
      flash[:error] = "You shouldn't be here!"
    end
  end

  def show
    if current_user.profile.blank?
      redirect_to new_user_profile_path(current_user.id)
    end



    if params[:id].blank?
      params[:user_id] = current_user.id
      params[:id] = current_user.profile.id
    end

    @profile = Profile.find(params[:id])
    @friendship = Friendship.where(:user_id => current_user.id, :friend_id => params[:user_id].to_i).first
    if @friendship.blank?
      @friendship = Friendship.where(:user_id => params[:user_id].to_i, :friend_id => current_user.id).first
    end

  end

  def edit
    byebug
    @profile = Profile.find(params[:id])

    redirect_to :back
  end

def update
    @profile = Profile.find(params[:id])
    @profile.first_name = params[:profile][:first_name]
    @profile.last_name = params[:profile][:last_name]
    @profile.avatar = params[:profile][:avatar]
    @profile.birthday = params[:profile][:birthday]
    @profile.save

    flash[:notice] = "User profile succesfully updated!"
    redirect_to user_profile_path(current_user.id, current_user.profile.id)
end

  def create
		
		@res = {
			:msg => 'Unknown Error'
			}
		
    @profile = Profile.new
    @profile.first_name = params[:first_name]
    @profile.last_name = params[:last_name]
    @profile.user_id = current_user.id
		
		@cats = params[:categories]
		@user = User.find(current_user.id)
		
		@cats.each do |cat| 
      @user.tags << Tag.find(cat[:id])
    end
		
		

    if @profile.save
      @user.wall = Wall.create()
      @feed = Feed.create(:user_id => current_user.id)
      FeedHistory.create(:feed_id => @feed.id)
			
			@res = {
				:redirect_url => user_profiles_path(current_user.id).to_s
				}
		end

    # Profile.create(:first_name => params[:profile][:first_name], :last_name => params[:profile][:last_name],
    #                :user_id => current_user.id, :avatar => "/images/default-avatar.png")
		
		render :json => { :redirect_url => user_profiles_path(current_user.id).to_s	}
  end
end
