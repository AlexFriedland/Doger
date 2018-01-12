puts "** Seeding Database: seeding...    **"
Time.new
sleep(2)

x = User.create(username: "alex", email: "a@alex.com", password: "a")

x.dogs << Dog.create(name: "Jay", user_id: "#{x.id}")
x.dogs << Dog.create(name: "Manny", user_id: "#{x.id}")

x = User.create(username: "harrison", email: "h@harrison.com", password: "h")

x.dogs << Dog.create(name: "Sophie", user_id: "#{x.id}")
x.dogs << Dog.create(name: "Mingie", user_id: "#{x.id}")

y = Walk.create(day: "#{Time.now}", from: "house", to: "house", miles: "1.15")

Dog.all.each do |dog|
  dog.walks << y
  y.dogs << dog
end

puts "**  Finishing  **"
