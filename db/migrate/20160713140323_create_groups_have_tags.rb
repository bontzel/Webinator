class CreateGroupsHaveTags < ActiveRecord::Migration
  def change
    create_table :groups_have_tags do |t|
      t.references :group, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
