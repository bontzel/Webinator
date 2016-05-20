class FriendshipsController < ApplicationController
respond_to :html, :xml, :json

  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id], :pending => true, :accepted => false, :read => false)
    if @friendship.save
      flash[:notice] = "Friend request sent!"
      redirect_to root_url
    else
      flash[:error] = "Unable to add friend."
      redirect_to root_url
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to root_url
  end

  def read_requests
    params[:_json].each do |f|
      Friendship.find(f).update(:read => true)
    end

    respond_to do |format|
      format.json  { render :json => params[:_json] } # don't do msg.to_json
    end

  end

  def accept_friendship
    @friendship = Friendship.find(params[:id])
    @friendship.update(:accepted => true)
    @friendship.update(:pending => false)
    Friendship.create(:user_id => @friendship.friend_id, :friend_id => @friendship.user_id, :pending => false, :accepted => true, :read => true)
    flash[:notice] = "Friend added!"

    redirect_to :back
  end

  def decline_friendship
    @friendship = Friendship.find(params[:id])
    @friendship.update(:accepted => false)
    @friendship.update(:pending => false)

    redirect_to :back
  end
end
