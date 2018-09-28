require_relative("../db/sql_runner.rb")

class Film

attr_reader(:id)
attr_accessor(:title, :price)

def initialize(options)
  @id = options["id"].to_i
  @title = options["title"]
  @price = options["price"].to_i
end

# delete all

def self.delete_all()
  sql = "DELETE from films;"
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
  INSERT INTO films( title, price )
  VALUES( $1, $2)
  RETURNING id
  ;"

  values = [@title, @price]

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

# update

# delete item

#end class
end
