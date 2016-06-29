class AddReferencesToSubcription < ActiveRecord::Migration
  def change
    add_reference :subscriptions, :user, index: true, foreign_key: true
    add_reference :subscriptions, :group, index: true, foreign_key: true
  end
end
