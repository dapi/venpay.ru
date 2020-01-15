# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


account = Account.create_with(
  cloud_payments_public_id: Rails.application.credentials.cloud_payments_public_id,
  cloud_payments_api_key: Rails.application.credentials.cloud_payments_api_key
).find_or_create_by(title: 'ROVOS')

account.machines.create_with(public_number: '1278', location: 'Офис').find_or_create_by(internal_id: 100020003)
PRICES = [
  { work_time: 5, price: 50.to_money(:rub), position: 0, title: '5 минут' },
  { work_time: 10, price: 90.to_money(:rub), position: 1, title: '10 минут' },
  { work_time: 20, price: 150.to_money(:rub), position: 2, title: '20 минут' },
]

PRICES.each do |price|
  account.prices.create_with(price: price[:price]).find_or_create_by(title: price[:title])
end

user = User.create!(email: 'admin@example.com', password: 'password')
account.users << user
