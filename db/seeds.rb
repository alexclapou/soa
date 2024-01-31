# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

u1 = User.create(name:'main')
u2 = User.create(name:'test')

Todo.create(name:"Todo-User-Main-1", user: u1)
Todo.create(name:"Todo-User-Main-2", user: u1)
Todo.create(name:"Todo-User-Test-1", user: u2)
Todo.create(name:"Todo-User-Main-3", user: u1)
Todo.create(name:"Todo-User-Main-4", user: u1)
Todo.create(name:"Todo-User-Test-2", user: u2)