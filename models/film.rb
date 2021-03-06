require_relative("../db/sql_runner.rb")

class Film

attr_reader(:id)
attr_accessor(:title)

def initialize(options)
  @id = options["id"].to_i
  @title = options["title"]
end

# delete all

def self.delete_all()
  sql = "DELETE from films;"
  SqlRunner.run(sql)
end

# hash_result

def self.hash_result(data)
  film_hash = data[0]
  film = Film.new(film_hash)
end

# map_items

def self.map_items(data)
  result = data.map{|film| Film.new(film) }
  return result
end

# save
def save()
  sql = "
  INSERT INTO films( title )
  VALUES( $1 )
  RETURNING id;"

  values = [@title]

  result = SqlRunner.run(sql,values)

# i seem to forget to do this part.
  #pick the first (and only) item out of the hash that's returned
  result_hash = result[0]
  # out of it, grab the id value and set that to a variable
  string_id = result_hash["id"]
  # convert it to an integer and save it as the id
  @id = string_id.to_i

end

# read all

def self.find_all()
  sql = " SELECT * FROM films;"
  data = SqlRunner.run(sql)
  Film.map_items(data)
end

# find by id
def self.find(id)
  sql = " SELECT * FROM films
  WHERE id = $1;"

  values = [id]

  data = SqlRunner.run(sql, values)
  film = Film.hash_result(data)
  film.title
end

# update

def update()
  sql = "UPDATE films
  SET title = $1
  Where id = $2;"

  values = [@title, @id]

  SqlRunner.run(sql, values)
end

# delete item
def delete()
  sql = "DELETE from films
  Where id = $1"

  values = [@id]
  SqlRunner.run(sql, values)
end

# film.customers

def customers()
  #we have the film id. we want to show all the customers who are seeing that film.

  # we'll need to take the film id to the tickets table, and get the customer ids, then get the customer names  - while the following shows EVERYTHING we want in postico - for the actual feature, we don't need to pull back the film title, because we're calling it from the film, so we can stop at the join for screenings

  sql = "SELECT customers.* FROM customers
  INNER JOIN tickets
  ON tickets.customer_id = customers.id
  INNER JOIN screenings
  ON tickets.screening_id = screenings.id
  WHERE film_id = $1;"

  result = SqlRunner.run(sql, [@id])
  Customer.map_items(result)
end

#number of customers going to see the film.
def customer_count()
  customers().count()
end

# screenings
def screenings()
  sql = "SELECT screenings.*, films.title
  FROM films
  INNER JOIN screenings
  ON screenings.film_id = films.id
  WHERE film_id = $1;"

  result = SqlRunner.run(sql, [@id])
  Screening.map_items(result)

end

# most popular screening time.

def most_popular()
  sql = "SELECT screenings.*, films.title
  FROM films
  INNER JOIN screenings
  ON screenings.film_id = films.id
  WHERE film_id = $1
  ORDER BY screenings.tickets_sold DESC;"

  result = SqlRunner.run(sql, [@id])
  #gives all sorted with most sold 1st
  screenings = Screening.map_items(result)
  #pulls out the show_time from the first result in that array
  screenings.first().show_time
end

#end class
end
