puts "** Seeding Database: seeding...    **"
Time.new
sleep(2)

alex = User.create(username: "alex", email: "a@alex.com", password: "a")

alex.dogs << Dog.create(name: "Jay", user_id: "#{alex.id}")
alex.dogs << Dog.create(name: "Manny", user_id: "#{alex.id}")

h = User.create(username: "harrison", email: "h@harrison.com", password: "h")

h.dogs << Dog.create(name: "Sophie", user_id: "#{h.id}")
h.dogs << Dog.create(name: "Mingie", user_id: "#{h.id}")

walk2 = Walk.create(day: "#{Time.now}", from: "house", to: "house", miles: "1.15")
walk1 = Walk.create(day: "#{Time.now}", from: "x location", to: "y locale", miles: "666")

Dog.all.each do |dog|
  dog.walks << [walk1, walk2]
  y.dogs << dog
end

binding.pry

puts "**  Complete  **"
