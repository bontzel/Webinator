class Tag < ActiveRecord::Base
  has_many :groups_have_tags
  has_many :groups, :through => :groups_have_tags
	
	has_many :user_interests
	has_many :users, :through => :user_interests
end
