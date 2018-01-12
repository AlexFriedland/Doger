x = User.create(username: "alex", email: "alex@alex.com", password: "a")

x.dogs << Dog.create(name: "Jay")
x.dogs << Dog.create(name: "Manny")
x.walks << Walk.create(day: "#{Time.now}")

=begin
t.datetime "day"
t.string "from"
t.string "to"
t.decimal "miles"
t.integer "dog_id"
t.integer "user_id"
=end

x = User.create(username: "harrison", email: "h@harrison.com", password: "h")

x.dogs << Dog.create(name: "Sophie")
x.dogs << Dog.create(name: "Mingie")
