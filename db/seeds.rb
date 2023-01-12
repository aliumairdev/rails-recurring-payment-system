# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.joins(:roles).where(roles: { name: :manager }).first
10.times do |index|
  plan = Plan.create(name: "Plan #{index}", monthly_fee: index * 5, manager_id: user.id)
  plan.features.build(name: "feature #{index}", code: index, unit_price: index * 5, manager_id: user.id)
  plan.save
end
