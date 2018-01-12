class CreateWalks < ActiveRecord::Migration[5.1]
  def change
    create_table :walks do |t|
      t.datetime :day
      t.string :from
      t.string :to
      t.decimal :miles
      t.integer :dog_id
      t.integer :user_id
    end
  end
end
