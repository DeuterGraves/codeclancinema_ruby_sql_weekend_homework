require_relative("../db/sql_runner.rb")

class Screening

  attr_reader(:id)
  attr_accessor(:film_id, :show_time, :price, :capacity, :tickets_sold)

def initialize(options)
  @id = options["id"].to_i
  @film_id = options["film_id"].to_i
  @show_time = options["show_time"]
  @price = options["price"].to_i
  @capacity = options["capacity"].to_i
  @tickets_sold = options["tickets_sold"].to_i
  # will want to move price here and remove it from film -- matinees will be cheaper than evening shows
end

# delete all

def self.delete_all()
  sql = "DELETE from screenings;"
  SqlRunner.run(sql)
end

# hash_result

def self.hash_result(data)
  screening_hash = data[0]
  screening = Screening.new(screening_hash)
end

# map_items

def self.map_items(data)
  result = data.map{|screening| Screening.new(screening) }
  return result
end

# save

def save()
  sql =  "INSERT INTO screenings (film_id, show_time, price, capacity, tickets_sold)
  VALUES ($1, $2, $3, $4, $5)
  RETURNING id;"

  values = [@film_id, @show_time, @price, @capacity, @tickets_sold ]

  result = SqlRunner.run(sql, values)
  result_hash = result[0]
  string_id = result_hash["id"]
  @id = string_id.to_i
end

# read all

def self.find_all()
  sql = " SELECT * from screenings;"
  data = SqlRunner.run(sql)
  Screening.map_items(data)
end

# update

def update()
 sql = "UPDATE screenings
 SET( film_id, show_time, price, capacity, tickets_sold)
 = ($1, $2, $3, $4, $5)
 Where id = $6;"

 values = [@film_id, @show_time, @price, @capacity, @tickets_sold, @id]

 SqlRunner.run(sql, values)
end

# delete item
def delete()
  sql = "DELETE from screenings
  Where id = $1"

  values = [@id]
  SqlRunner.run(sql, values)
end

def customers()
  #list of customers at a screening =
  #tickets table has screening id and customer id

  #we have the screening id when we call this on a screening. we want to show all the customers who are seeing that screening.

  # we'll need to take the screening id to the tickets table, and get the customer ids, then get the customer names .

  #INNERJOIN!!!
  sql = "SELECT customers.* FROM customers
  INNER JOIN tickets
  ON tickets.customer_id = customers.id
  WHERE screening_id = $1;"

  result = SqlRunner.run(sql, [@id])
  Customer.map_items(result)
end

# number of tickets sold for a screening ^ length of that probab

def customer_count()
  customers().count()
end

# check capacity for sale.

def tickets_left?()
  #tickets_sold = customer_count()
  @tickets_sold < @capacity
end

def ticket_sold()
  @tickets_sold += 1
end



# most popular showing

def self.most_popular()
  sql = "SELECT screenings.*, films.title
FROM films
INNER JOIN screenings
ON screenings.film_id = films.id
ORDER BY screenings.tickets_sold DESC;"

result = SqlRunner.run(sql)
Screening.map_items(result)


  # we can get each screening's customer count.  ticket count is easier.
  # pull count for all, compare which has the highest?
  # OR add a column to the screenings table and increment it for each ticket sold. then sql search in desc order by that column.
end


# class end
end

=begin
some things will need to happen.
1. price needs to be shifted here
  this will break price and decrease wallet - so fix that.
2. when a ticket is purchased - it's really a screening that's purchased, not the film.
  will need to change that...
  ticket will connect screening and customer

  film.customer() - this will need to dig through the screening table and get the film id to go to the
3. a count of sold tickets for the showing needs to be taken... hrm... that could be done in the table or it could be done with a join table.



=end
