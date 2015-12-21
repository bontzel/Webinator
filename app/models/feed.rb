class Feed < ActiveRecord::Base
  belongs_to :user
  has_one :feed_history

  accepts_nested_attributes_for :feed_history,
    :reject_if => :all_blank,
    :allow_destroy => true
end
