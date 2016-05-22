class AddLikersCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :likers_count, :integer
  end
end
