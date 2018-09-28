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

#.films booked (list)

# buy ticket (funds decrease)

# how many .tickets purchased



# end class
end
