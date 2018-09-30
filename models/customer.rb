require_relative("../db/sql_runner.rb")

class Customer

attr_reader(:id)
attr_accessor(:name, :funds)

def initialize(options)
  @id = options["id"].to_i
  @name = options["name"]
  @funds = options["funds"].to_i
end

# delete all

def self.delete_all()
  sql = "DELETE from customers;"
  SqlRunner.run(sql)
end


# hash_result

def self.hash_result(data)
  customer_hash = data[0]
  customer = Customer.new(customer_hash)
end

# map_items

def self.map_items(data)
  result = data.map{|customer| Customer.new(customer) }
  return result
end

# save
def save()
  sql = "
  INSERT INTO customers(name, funds)
  VALUES($1, $2)
  RETURNING id;"

  values = [@name, @funds]

  result = SqlRunner.run(sql, values)

#ok. here we go. get the only thing from the result
  result_hash = result[0]
  #now grab the data stored in 'id'
  string_id = result_hash["id"]
  # and save it to the id variable as an integer
  @id = string_id.to_i
end

# read all

def self.find_all()
  sql = "SELECT * from customers;"
  data = SqlRunner.run(sql)
  Customer.map_items(data)
end

# update

def update()
  sql = "UPDATE customers
  SET(name, funds)
  = ($1, $2)
  WHERE id = $3;"

  values = [@name, @funds, @id]

  SqlRunner.run(sql, values)
end

# delete item
def delete()
  sql = "DELETE from customers
  Where id = $1"

  values = [@id]
  SqlRunner.run(sql, values)
end
#.films booked (list)

def films()
  sql = "SELECT films.* FROM films
  INNER JOIN tickets
  ON films.id = tickets.film_id
  WHERE customer_id = $1;"

  result = SqlRunner.run(sql, [@id])
  Film.map_items(result)

end

# funds decrease

def pays_for_ticket(screening)
  # find the price
  value = screening.price
  # find the funds
  # this is being called ON customer so just call it's parameter directly.
  wallet = @funds
  #subtract price from funds
  remaining_funds = wallet -= value
  # update funds locally
  @funds = remaining_funds
  # update funds in db
  update()
end

# buy ticket - funds decrease ticket created.... ooooooo

def buys_ticket(screening)
  # eventually this will need something for counting capacity.
  pays_for_ticket(screening)
  ticket = Ticket.new({"customer_id" => @id,
    "screening_id" => screening.id})
    ticket.save()
end

# how many .tickets purchased - returns a number. oooo array length

def tickets_purchased()
  #called on customer so
  # customer.films.count basically.
  films().count()
end

# end class
end
