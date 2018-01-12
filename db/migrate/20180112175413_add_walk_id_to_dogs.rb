class AddWalkIdToDogs < ActiveRecord::Migration[5.1]
  def change
    add_column :dogs, :walk_id, :integer
  end
end
