class HasManyThrough < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :walks do |t|
      t.integer :user_id
      t.integer :walk_id
    end
  end
end

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
