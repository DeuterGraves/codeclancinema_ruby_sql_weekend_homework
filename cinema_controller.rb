require_relative("./models/customer.rb")
require_relative("./models/film.rb")
require_relative("./models/ticket.rb")
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
ticket1 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film1.id
  })



binding.pry
puts "Well, whadda ya know?!"
