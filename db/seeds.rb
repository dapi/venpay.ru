# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


account = Account.find_or_create_by(
  title: 'ROVOS',
  cloud_payments_public_id: Rails.application.credentials.cloud_payments_public_id,
  cloud_payments_api_key: Rails.application.credentials.cloud_payments_api_key
)

account.machines.create_with(public_number: '1278', location: 'Офис Данила').find_or_create_by(internal_id: 100020003)
PRICES = [
  { price: 50.to_money(:rub), title: '5 минут' },
  { price: 90.to_money(:rub), title: '10 минут' },
  { price: 150.to_money(:rub), title: '20 минут' },
]

PRICES.each do |price|
  account.prices.create_with(price: price[:price]).find_or_create_by(title: price[:title])
end
