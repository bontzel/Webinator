class ProfilesController < ApplicationController
  def index
    @profile = current_user.profile
    if @profile.blank? 
      redirect_to new_user_profile_path(current_user.id)
    end
  end
  
  def new
    @profile = Profile.new
    @user = current_user
  end
  
  def create
    Profile.create(:first_name => params[:profile][:first_name], :last_name => params[:profile][:last_name], :user_id => current_user.id)
    redirect_to user_profiles_path(current_user.id)
  end
end
