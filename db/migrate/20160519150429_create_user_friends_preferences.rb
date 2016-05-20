class CreateUserFriendsPreferences < ActiveRecord::Migration
  def change
    create_table :user_friends_preferences do |t|
      t.references :user, index: true, foreign_key: true
      t.string :entries, :array => true

      t.timestamps null: false
    end
  end
end
