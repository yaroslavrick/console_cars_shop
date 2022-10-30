require './autoload'

cars_management = CarsManagement.new('lib/database/db.yml')

cars_management.run
