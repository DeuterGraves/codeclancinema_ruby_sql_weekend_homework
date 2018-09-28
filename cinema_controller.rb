require_relative("./models/customer.rb")
require("pry")

customer1 = Customer.new({
  "name" => "Rebecca Davenport",
  "funds" => 50
  })


  binding.pry
  puts "Well, whadda ya know?!"
