# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Work.destroy_all
Comment.destroy_all

userComment = Comment.create(username: "Xavi", content: "Nice project")
userWork = Work.create(title: "title 1", description: "description1")

userWork.comments << userComment

puts "Succesfull Seed!!"
