class Tag < ActiveRecord::Base
  has_many :groups_have_tags
  has_many :groups, :through => :groups_have_tags
end
