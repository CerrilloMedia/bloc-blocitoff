require 'faker'

10.times do
    email = Faker::Internet.email
    password = Faker::Internet.password
    User.create!( email: email, password: password )
end

users = User.all

20.times do 
    user = users.sample
    title = Faker::Lorem.sentence(4)[0...50]
    completed = Faker::Boolean.boolean
    completed_at = completed ? Time.now : nil
    
    List.create!(
        title: title,
        user_id: user.id,
        completed: completed,
        completed_at: completed_at
        )
end

lists = List.all

30.times do
    list = lists.sample
    body = Faker::Lorem.sentence(6)
    completed = [true, false].sample
    completed_at = completed ? Time.now : nil
    
    Item.create!(
        user_id: list.user_id,
        list_id: list.id,
        body: body,
        completed: completed,
        completed_at: completed_at
        )
end

puts "generated #{User.all.count} users"
puts "generated #{List.all.count} lists"
puts "generated #{Item.all.count} items"