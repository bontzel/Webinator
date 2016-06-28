class AddAdminToGroup < ActiveRecord::Migration
  def change
		add_column :groups, :admin_id, :integer, index: true
		add_foreign_key :groups, :users, column: :admin_id
  end
end
