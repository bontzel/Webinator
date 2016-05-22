class CreateUserPopularities < ActiveRecord::Migration
  def change
    create_table :user_popularities do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :likers, :array => true

      t.timestamps null: false
    end
  end
end
