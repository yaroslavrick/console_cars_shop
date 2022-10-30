class CarsManagement
  include Database
  include InputOutput
  include Search

  def initialize(database_filename)
    @database_filename = database_filename
    @running = true
  end

  def run
    while @running
      cars = load_db(@database_filename)
      options = ask_user_input
      query = create_query(options)
      result = search(cars, query)
      print_result(result)
      @running = false if exit?
    end
  end
end
