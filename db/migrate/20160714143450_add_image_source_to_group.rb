class AddImageSourceToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :imageSource, :string
  end
end
