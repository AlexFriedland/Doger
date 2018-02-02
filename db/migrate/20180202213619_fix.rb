class Fix < ActiveRecord::Migration[5.1]
  def change
    drop_table :dogs_walks

    create_table :dog_walks do |t|
      t.integer :dog_id
      t.integer :walk_id
    end
  end
end
