class CreateFeedHistoryHasPosts < ActiveRecord::Migration
  def change
    create_table :feed_history_has_posts do |t|
      t.references :feed_history, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
