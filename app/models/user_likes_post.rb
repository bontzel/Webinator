class UserLikesPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :postable, :polymorphic => true
end
