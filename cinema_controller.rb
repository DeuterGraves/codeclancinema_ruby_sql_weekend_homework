require_relative("./models/customer.rb")
require_relative("./models/film.rb")
require_relative("./models/ticket.rb")
require_relative("./models/screening.rb")
require("pry")

# delete customers
Customer.delete_all()
# delete films
Film.delete_all()
# delete tickets
Ticket.delete_all()
Screening.delete_all()

# build and save customers

customer1 = Customer.new({
  "name" => "Rebecca Broadport",
  "funds" => 50
  })

customer2 = Customer.new({
  "name" => "Susie Davenreach",
  "funds" => 20
  })

customer3 = Customer.new({
  "name" => "David Sunderlund",
  "funds" => 40
  })

customer4 = Customer.new({
  "name" => "Sean Whithlewhite",
  "funds" => 40
  })

customer5 = Customer.new({
  "name" => "Robert Jones",
  "funds" => 40
  })

customer6 = Customer.new({
  "name" => "Terrance Northrup",
  "funds" => 40
  })

customer7 = Customer.new({
  "name" => "Bea Whitty",
  "funds" => 40
  })


customer1.save()
customer2.save()
customer3.save()
customer4.save()
customer5.save()
customer6.save()
customer7.save()

  # build and save films
film1 = Film.new({
  "title" => "Charlie and the Chocolate Factory",
  # "price" => 1
  })

# film2 = Film.new({
#   "title" => "The Lost Boys",
#   # "price" => 2
#   })
#
# film3 = Film.new({
#   "title" => "Baby Driver",
#   # "price" => 5
#   })

film2 = Film.new({
  "title" => "Night School",
  # "price" => 10
  })

film3 = Film.new({
  "title" => "Crazy Rich Asians",
  # "price" => 10
  })


film1.save()
film2.save()
film3.save()
# film4.save()
# film5.save()


  # set up and save tickets

  # I'm holding off on changing anything about tickets - when a customer purchases a screening, it'll create a ticket, that code is updated and working correctly. no need to preload tickets.

# ticket1 = Ticket.new({
#   "customer_id" => customer1.id,
#   "film_id" => film1.id
#   })
#
# ticket2 = Ticket.new({
#   "customer_id" => customer1.id,
#   "film_id" => film2.id
#   })
#
# ticket3 = Ticket.new({
#   "customer_id" => customer2.id,
#   "film_id" => film3.id
#   })
#
# ticket4 = Ticket.new({
#   "customer_id" => customer2.id,
#   "film_id" => film4.id
#   })
#
# ticket5 = Ticket.new({
#   "customer_id" => customer3.id,
#   "film_id" => film5.id
#   })
#
# ticket6 = Ticket.new({
#   "customer_id" => customer3.id,
#   "film_id" => film1.id
#   })
#
# ticket7 = Ticket.new({
#   "customer_id" => customer2.id,
#   "film_id" => film5.id
#   })
#
# ticket8 = Ticket.new({
#   "customer_id" => customer1.id,
#   "film_id" => film4.id
#   })

#
# ticket1.save
# ticket2.save
# ticket3.save
# ticket4.save
# ticket5.save
# ticket6.save
# ticket7.save
# ticket8.save

screening1 = Screening.new({
  "film_id" => film1.id,
  "show_time" => "11:40",
  "price" => 1,
  "capacity" => 4
  })

screening2 = Screening.new({
  "film_id" => film2.id,
  "show_time" => "11:40",
  "price" => 6,
  "capacity" => 4
  })

screening3 = Screening.new({
  "film_id" => film3.id,
  "show_time" => "11:40",
  "price" => 6,
  "capacity" => 4
  })

screening4 = Screening.new({
  "film_id" => film1.id,
  "show_time" => "20:30",
  "price" => 2,
  "capacity" => 4
  })

screening5 = Screening.new({
  "film_id" => film2.id,
  "show_time" => "20:00",
  "price" => 10,
  "capacity" => 4
  })

screening6 = Screening.new({
  "film_id" => film3.id,
  "show_time" => "21:00",
  "price" => 10,
  "capacity" => 4
  })

screening1.save()
screening2.save()
screening3.save()
screening4.save()
screening5.save()
screening6.save()


film1.title = "Caddyshack"
film1.update()
customer1.name = "Rebecca Davenport"
customer1.update()
customer2.name = "Susie Broadreach"
customer2.update()
# # ticket4.screening_id = 69
# # ticket4.update()
# film2.delete()
# ticket8.delete()
# customer2.delete()
screening1.film_id = film1.id
screening1.update()
# screening1.delete()

p screening1.customers()
# p film5.customers()
#p customer3.films()
# p customer2.films()

binding.pry
# # customer1.pays_for_ticket(film1)
customer1.buys_ticket(screening1)
customer2.buys_ticket(screening1)
customer3.buys_ticket(screening1)
customer4.buys_ticket(screening1)
customer5.buys_ticket(screening1) 

binding.pry
puts "Well, whadda ya know?!"
