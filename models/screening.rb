require_relative("../db/sql_runner.rb")

class Screening

  attr_reader(:id)
  attr_accessor(:film_id, :show_time, :capacity)

def initialize(options)
  @id = options["id"].to_i
  @film_id = options["film_id"].to_i
  @show_time = options["show_time"]
  @capacity = options["capacity"].to_i
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
  screening = Customer.new(screening_hash)
end

# map_items

def self.map_items(data)
  result = data.map{|screening| Screening.new(screening) }
  return result
end

# save

def save()
  sql =  "INSERT INTO screenings (film_id, show_time, capacity)
  VALUES ($1, $2, $3)
  RETURNING id;"

  values = [@film_id, @show_time, @capacity]

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
 SET( film_id, show_time, capacity)
 = ($1, $2, $3)
 Where id = $4;"

 values = [@film_id, @show_time, @capacity, @id]

 SqlRunner.run(sql, values)
end

# delete item
def delete()
  sql = "DELETE from screenings
  Where id = $1"

  values = [@id]
  SqlRunner.run(sql, values)
end

# most popular showing

# attempt to oversell tickets


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
