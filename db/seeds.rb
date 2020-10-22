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
Favorite.create(user: austin, stock: tsla)
Favorite.create(user: austin, stock: aapl)

# IEX_KEY = ENV['iex_publishable_key']
#
# CLIENT = IEX::Api::Client.new(
#   publishable_token: IEX_KEY,
#   endpoint: 'https://cloud.iexapis.com/v1'
# )
# CLIENT.ref_data_symbols().each do |element|
#   CompanyTicker.create(symbol:element.symbol, name:element.name )
# end
