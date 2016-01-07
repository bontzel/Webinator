class AddPendingToFriendship < ActiveRecord::Migration
  def change
    add_column(:friendships, :pending, :boolean)
  end
end
