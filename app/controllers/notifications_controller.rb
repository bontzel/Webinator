class NotificationsController < ApplicationController
  respond_to :json

  def read_notifications
    params[:notifications].each do |f|
      Notification.find(f).update(:seen => true)
    end

    respond_to do |format|
      format.json  { render :json => params[:_json] } # don't do msg.to_json
    end

  end
end
