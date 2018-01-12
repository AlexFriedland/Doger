class DropUserIdFromWalks < ActiveRecord::Migration[5.1]
  def change
    remove_column(:walks, :user_id)
  end
end
