require_relative("./models/customer.rb")
require_relative("./models/film.rb")
require_relative("./models/ticket.rb")
require("pry")

# delete customers
Customer.delete_all()
# delete films
Film.delete_all()
# delete tickets
Ticket.delete_all()

# build and save customers

customer1 = Customer.new({
  "name" => "Rebecca Davenport",
  "funds" => 50
  })

customer2 = Customer.new({
  "name" => "Susie Broadreach",
  "funds" => 20
  })

customer3 = Customer.new({
  "name" => "David Sunderlund",
  "funds" => 40
  })


customer1.save()
customer2.save()
customer3.save()

  # build and save films
film1 = Film.new({
  "title" => "Charlie and the Chocolate Factory",
  "price" => 1
  })

film2 = Film.new({
  "title" => "The Lost Boys",
  "price" => 2
  })

film3 = Film.new({
  "title" => "Baby Driver",
  "price" => 5
  })

film4 = Film.new({
  "title" => "Night School",
  "price" => 10
  })

film5 = Film.new({
  "title" => "Crazy Rich Asians",
  "price" => 10
  })


film1.save()
film2.save()
film3.save()
film4.save()
film5.save()


  # set up and save tickets
ticket1 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film1.id
  })

ticket2 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film2.id
  })

ticket3 = Ticket.new({
  "customer_id" => customer2.id,
  "film_id" => film3.id
  })

ticket4 = Ticket.new({
  "customer_id" => customer2.id,
  "film_id" => film4.id
  })

ticket5 = Ticket.new({
  "customer_id" => customer3.id,
  "film_id" => film5.id
  })

ticket6 = Ticket.new({
  "customer_id" => customer3.id,
  "film_id" => film1.id
  })

ticket7 = Ticket.new({
  "customer_id" => customer2.id,
  "film_id" => film5.id
  })

ticket8 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film4.id
  })


ticket1.save
ticket2.save
ticket3.save
ticket4.save
ticket5.save
ticket6.save
ticket7.save
ticket8.save

film1.title = "Caddyshack"
film1.update()
# customer1.name = "Rebecca Broadport"
# customer1.update()
# customer2.name = "Susie Davenreach"
# customer2.update()
# # ticket4.film_id = 69
# # ticket4.update()
# film2.delete()
# ticket8.delete()
# customer2.delete()

p film1.customers()
p film5.customers()
p customer3.films()
p customer2.films()

binding.pry 
# # customer1.pays_for_ticket(film1)
customer1.buys_ticket(film5)

binding.pry
puts "Well, whadda ya know?!"
