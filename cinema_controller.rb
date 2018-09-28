require_relative("./models/customer.rb")
require_relative("./models/film.rb")
require("pry")

# delete customers
# delete films
# delete tickets

# build and save customers

customer1 = Customer.new({
  "name" => "Rebecca Davenport",
  "funds" => 50
  })

  # build and save films
film1 = Film.new({
  "title" => "Charlie and the Chocolate Factory",
  "price" => 2
  })



  # set up and save tickets




  binding.pry
  puts "Well, whadda ya know?!"
