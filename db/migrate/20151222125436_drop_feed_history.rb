class DropFeedHistory < ActiveRecord::Migration
  def change
    drop_table :feed_histories
  end
end
