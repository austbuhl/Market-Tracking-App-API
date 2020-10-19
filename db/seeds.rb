# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


austin = User.create(name: 'Austin')

msft = Stock.create(company_name: 'Microsoft', ticker: 'MSFT')
tsla = Stock.create(company_name: 'Tesla', ticker: 'TSLA')
aapl = Stock.create(company_name: 'Apple Inc.', ticker: 'AAPL')

Favorite.create(user: austin, stock: msft)
