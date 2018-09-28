require_relative("../db/sql_runner.rb")

class Customer

attr_reader(:id)
attr_accessor(:name, :funds)

def initialize(options)
  @id = options["id"].to_i
  @name = options["name"]
  @funds = options["funds"].to_i
end



  #end class
end
