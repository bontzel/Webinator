class Post < ActiveRecord::Base
  validates :text, length: { minimum: 2 }
  belongs_to :wall
  belongs_to :user
end
