class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :actor, :class_name => "User"
  belongs_to :notifiable, polymorphic: true
  #  Notification.create(:user_id => 13, :actor_id => 12, :notifiable_id => 7, :notifiable_type => 'Post', :message_type => 0, :seen => false)
end
