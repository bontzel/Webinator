class Group < ActiveRecord::Base
	has_one :user, foreign_key: :admin_id
	has_many :users, :through => :subscriptions
end
