class RemoveBirthdayFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :birthday, :date
  end
end
