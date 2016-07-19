class Group < ActiveRecord::Base
	belongs_to :admin, class_name: 'User'
	has_many :subscriptions
	has_many :users, :through => :subscriptions
	has_one :wall, as: :walled
  
  has_many :groups_have_tags
  has_many :tags, :through => :groups_have_tags
end
