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

