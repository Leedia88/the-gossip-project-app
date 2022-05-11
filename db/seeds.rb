# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

# City.destroy_all
# User.destroy_all
# Gossip.destroy_all
# Tag.destroy_all
# TagsGossip.destroy_all
# PrivateMessage.destroy_all

# "villes
puts "Cities"
15.times do
    city = City.new(name: Faker::Nation.capital_city, zip_code: Faker::Address.postcode)
    if city.save
    #   p "#{city.name}"
    end
end

#users
puts "Users"
30.times do
    firstname = Faker::Name.first_name
    lastname = Faker::Name.last_name
    email = firstname[0].downcase + "." + lastname.downcase + "@thp.com"
    password = Faker::Name.first_name + Faker::Name.first_name
    User.create!(first_name: firstname, last_name: lastname , email: email, description: Faker::Quote.jack_handey, password: password, city_id: Faker::Number.between(from: City.all.first.id, to: City.all.last.id), age: Faker::Number.within(range: 20..40))
    # p "#{user.first_name} #{user.first_name}"
end

#gossips
50.times do
    Gossip.create!(title: Faker::Fantasy::Tolkien.poem, content: Faker::Quote.matz, user_id: Faker::Number.between(from: User.all.first.id, to: User.all.last.id) )
end

#tags
colors = ["#01A490", "#00AEEF", "#ED1C24", "Coral", "#FFEE5B", "#7252E7", "Aquamarine" ,"#C2135A", "Orange","Purple"]
10.times do

    color = colors.pop()
    Tag.create!(title: Faker::Emotion.noun, color: color)
end

#tags_gossips
    Gossip.all.each do |gossip|
        nb = rand(1..3)
        # puts "GOSSIP ##{gossip.id} : #{gossip.title} "
        # puts gossip.content
        # p "Tags :"
        nb.times do
            tag = TagGossip.new(tag_id: Faker::Number.between(from: Tag.all.first.id, to: Tag.all.last.id), gossip_id: gossip.id )
            if tag.save   
                # p Tag.find(tag.tag_id).title + "  " + Tag.find(tag.tag_id).color
            end
        end
    end

#Private Messages
5.times do
    pm = PrivateMessage.new(content: Faker::Books::Lovecraft.sentence, sender_id: Faker::Number.between(from: User.all.first.id, to: User.all.last.id), recipient_id: Faker::Number.between(from: User.all.first.id, to: User.all.last.id))
    if pm.save
        # puts "message : #{pm.content}"
        # puts "sent by : #{User.find(pm.sender_id).first_name} #{User.find(pm.sender_id).last_name}"
        # puts "to : #{User.find(pm.recipient_id).first_name} #{User.find(pm.recipient_id).last_name}"+"\n"
    else
        puts "message non envoyé!"+"\n"
    end  
end 

# puts "fini!!!"