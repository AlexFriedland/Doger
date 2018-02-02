class HasManyThrough < ActiveRecord::Migration[5.1]
  def change
    create_join_table :dogs, :walks do |t|
      t.integer :dog_id
      t.integer :walk_id
    end

    #remove walk_id from dogs, has through dog_walks
    remove_column :dogs, :walk_id

    #remove dog_id from walks, has through dog_walks
    remove_column :walks, :dog_id
  end
end


=begin
  create_table "dogs", force: :cascade do |t|
    t.string "name"
    t.integer "walk_id"
    t.integer "user_id"
  end

  #has_many :user_walks
  #has_many :walks, through: :user_walks
  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

  create_table "walks", force: :cascade do |t|
    t.datetime "day"
    t.string "from"
    t.string "to"
    t.decimal "miles"
    t.integer "dog_id"
  end
=end
