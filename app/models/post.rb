class Post < ActiveRecord::Base
  validates :text, length: { minimum: 2 }
  belongs_to :wall
  belongs_to :user
  has_many :feed_history_has_posts
  has_many :feed_histories, through: :feed_history_has_post
  has_many :comments
  has_many :user_likes_posts, :as => :likeable
  has_many :users, :through => :user_likes_posts
  has_one :notification, :as => :notifiable
end
