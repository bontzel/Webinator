class ProfilesController < ApplicationController
  helper ApplicationHelper

  def index
    @profile = current_user.profile
    if @profile.blank?
      redirect_to new_user_profile_path(current_user.id)
    end
  end

  def new
    @profile = Profile.new
  end

  def show
    @profile = Profile.find(params[:id])
    @friendship = Friendship.where(:user_id => current_user.id, :friend_id => params[:user_id].to_i).first
    if @friendship.blank?
      @friendship = Friendship.where(:user_id => params[:user_id].to_i, :friend_id => current_user.id).first
    end

  end

  def edit
    @profile = Profile.find(params[:id])
  end

def update
    @profile = Profile.find(params[:id])
    @profile.first_name = params[:profile][:first_name]
    @profile.last_name = params[:profile][:last_name]
    @profile.avatar = params[:profile][:avatar]
    @profile.save

    flash[:notice] = "User profile succesfully updated!"
    redirect_to user_profile_path(current_user.id, current_user.profile.id)
end

  def create
    @profile = Profile.new
    @profile.first_name = params[:profile][:first_name]
    @profile.last_name = params[:profile][:last_name]
    @profile.user_id = current_user.id

    if @profile.save
      Wall.create(:user_id => current_user.id)
      @feed = Feed.create(:user_id => current_user.id)
      FeedHistory.create(:feed_id => @feed.id)
    end

    # Profile.create(:first_name => params[:profile][:first_name], :last_name => params[:profile][:last_name],
    #                :user_id => current_user.id, :avatar => "/images/default-avatar.png")

    redirect_to user_profiles_path(current_user.id)
  end
end
