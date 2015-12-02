class AddWallToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :wall, index: true, foreign_key: true
  end
end
