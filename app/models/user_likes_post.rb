class UserLikesPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :likeable, :polymorphic => true
end
