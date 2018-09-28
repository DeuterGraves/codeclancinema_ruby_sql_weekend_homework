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

# read all

# update

# delete item

#.films booked (list)

# buy ticket (funds decrease)

# how many .tickets purchased



# end class
end
