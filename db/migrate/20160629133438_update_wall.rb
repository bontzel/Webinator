class UpdateWall < ActiveRecord::Migration
  def change
		remove_column :walls, :user_id
		add_column :walls, :walled_id, :integer
		add_column :walls, :walled_type, :string
		
		add_index :walls, :walled_id
  end
end
