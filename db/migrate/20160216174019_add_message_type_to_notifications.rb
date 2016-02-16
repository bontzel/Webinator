class AddMessageTypeToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :message_type, :integer
  end
end
