class FeedHistoryHasPost < ActiveRecord::Base
  belongs_to :feed_history
  belongs_to :post
end
