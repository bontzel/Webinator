class FeedHistory < ActiveRecord::Base
  belongs_to :feed
  has_many :feed_history_has_posts
  has_many :posts, through: :feed_history_has_posts
end
