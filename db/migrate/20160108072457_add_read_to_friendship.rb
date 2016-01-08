class AddReadToFriendship < ActiveRecord::Migration
  def change
    add_column(:friendships, :read, :boolean)
  end
end
