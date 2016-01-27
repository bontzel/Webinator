class CreateUserLikesPost < ActiveRecord::Migration
  def change
    create_table :user_likes_posts do |t|
      t.references :user, index: true, foreign_key: true
      t.references :likeable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
