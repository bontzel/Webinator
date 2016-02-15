class Comment < ActiveRecord::Base
  validates :text, length: { minimum: 2 }
  belongs_to :user
  belongs_to :post
  has_many :user_likes_posts, :as => :likeable
  has_many :users, :through => :user_likes_posts
  has_one :notification, :as => :notifiable
end
