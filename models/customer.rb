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

# map_items

# save

# read all

# update

# delete item

#.films booked (list)

# buy ticket (funds decrease)

# how many .tickets purchased



# end class
end
