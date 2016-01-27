class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_one :wall
  has_many :posts
  has_one :profile
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :user_likes_posts
  has_many :posts, :through => :user_likes_posts, :source => :postable, :source_type => 'Post'
  has_many :comments, through => :user_likes_posts, :source => :postable, :source_type => 'Comment'
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_one :feed
  has_one :feed_history, through: :feed
  has_many :comments

  accepts_nested_attributes_for :feed_history,
    :reject_if => :all_blank,
    :allow_destroy => true
end
