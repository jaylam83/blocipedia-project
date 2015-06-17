require 'faker'
#Create Users
  10.times do 
    user = User.new(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: Faker::Lorem.characters(10)
      )
      user.skip_confirmation!
      user.save!
    end
    users = User.all
# Create Wikis
100.times do 
   wiki = Wiki.create!(
    user: users.sample,
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    )

    wiki.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
  end

#Create admin User
    admin = User.new(
      name: 'Admin User',
      email: 'admin@example.com',
      password: '12345678'
      )
      admin.skip_confirmation!
      admin.save!
      admin.role = "admin"
      admin.save!
    

    premium = User.new(
      name: 'Premium User',
      email: 'premium@example.com',
      password: '12345678'
      )
      premium.skip_confirmation!
      premium.save!
      premium.role = "premium"
      premium.save!
    

    standard = User.new(
      name: 'Standard User',
      email: 'standard@example.com',
      password: '12345678'
      )
      standard.skip_confirmation!
      standard.save!
    
 puts "Seed finished"
 puts "#{Wiki.count} wikis created"
 puts "#{User.count} users created"




