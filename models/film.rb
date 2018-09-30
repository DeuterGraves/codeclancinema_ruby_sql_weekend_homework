require_relative("../db/sql_runner.rb")

class Film

attr_reader(:id)
attr_accessor(:title)
#:price)

def initialize(options)
  @id = options["id"].to_i
  @title = options["title"]
  # @price = options["price"].to_i
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
  # convert it to an interger and save it as the id
  @id = string_id.to_i

end

# read all

def self.find_all()
  sql = " SELECT * from films;"
  data = SqlRunner.run(sql)
  Film.map_items(data)
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

# this functionality may be moved to screenings.
def customers()
  #we have the film id. we want to show all the customers who are seeing that film.

  # we'll need to take the film id to the tickets table, and get the customer ids, then get the customer names .
  # SELECT customers.name, screenings.id, films.title
  # FROM customers
  # INNER JOIN tickets
  # ON tickets.customer_id = customers.id
  #INNER JOIN screenings
  #ON tickets.screening_id = screenings.id
  # INNER JOIN films
  # ON screenings.film_id = films.id

  #INNERJOIN!!!
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
#end class
end
