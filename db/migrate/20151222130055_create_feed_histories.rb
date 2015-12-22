class CreateFeedHistories < ActiveRecord::Migration
  def change
    create_table :feed_histories do |t|
      t.references :feed, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
