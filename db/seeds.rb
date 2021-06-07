# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

name = "nanashi"
email = "nanashi@nameless.com"
password = "7777777"
User.create!( name: name,
              email: email,
              password: password,
              password_confirmation: password,
              admin: true
            )

Label.create!(
  [
    {name: '見積'},
    {name: 'E-TKT'},
    {name: 'PAX FNL'},
    {name: 'NEW BOOK'},
    {name: 'REBOOK'},
    {name: '新規営業'},
    {name: 'アポ'},
    {name: '保険'},
    {name: 'NET CHK'},
    {name: 'FNL CHK'}
  ]
)

10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password,
                admin: false
                )
end

10.times do |n|
  title = Faker::Games::Pokemon.move
  content = Faker::Games::Pokemon.location
  limit = Faker::Date.between(from: '2021-05-27', to: '2021-09-27')
  user_id = n + 1
  Task.create!(title: title,
                content: content,
                limit: limit,
                user_id: user_id
                )
end