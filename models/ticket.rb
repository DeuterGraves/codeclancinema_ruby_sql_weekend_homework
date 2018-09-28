require_relative("../db/sql_runner.rb")

class Ticket

attr_reader(:id)
attr_accessor(:customer_id, :film_id)

def initialize(options)
  @id = options["id"].to_i
  @customer_id = options["customer_id"].to_i
  @film_id = options["film_id"].to_i
end

# delete all

def self.delete_all()
  sql = "DELETE from tickets;"
  SqlRunner.run(sql)
end

# hash_result

def self.hash_result(data)
  customer_hash = data[0]
  customer = Customer.new(customer_hash)
end

# map_items

def self.map_items(data)
  result = data.map{|ticket| Ticket.new(ticket) }
  return result
end

# save
def save()
  sql = "
  INSERT INTO tickets(customer_id, film_id)
  VALUES($1, $2)
  RETURNING id;"

  values = [@customer_id, @film_id]

  result = SqlRunner.run(sql, values)

  result_hash = result[0]
  string_id = result_hash["id"]
  @id = string_id.to_i
end

# read all

def self.find_all()
  sql = "SELECT * from tickets;"
  data = SqlRunner.run(sql)
  Ticket.map_items(data)
end

# update

def update()
  sql = "UPDATE tickets
  SET (customer_id, film_id)
  = ($1, $2)
  WHERE id = $3;"

  values = [@customer_id, @film_id, @id]

  SqlRunner.run(sql, values)
end

# delete item

# end class
end
