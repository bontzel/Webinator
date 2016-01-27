class CreateUserLikesPosts < ActiveRecord::Migration
  def change
    create_table :user_likes_posts do |t|
      t.user :references
      t.post :refrences

      t.timestamps null: false
    end
  end
end
