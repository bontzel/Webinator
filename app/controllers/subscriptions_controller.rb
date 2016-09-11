class SubscriptionsController < ApplicationController

  def create
    Subscription.create(:user_id => params[:user_id], :group_id => params[:group_id])

    redirect_to user_group_path(current_user.id, params[:group_id])
  end

  def delete
    Subscription.where(:user_id => params[:user_id], :group_id => params[:group_id]).destroy_all

    redirect_to  user_groups_path(current_user.id)
  end

end
