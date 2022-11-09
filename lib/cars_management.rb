class CarsManagement
  include Lib
  include InputOutput
  include DataBase
  include SearchEngine

  def initialize
    @running = true
  end

  def run
    while @running == true
      search_rules_hash = ask_user_input
      database = load_database
      database = keep('make', search_rules_hash[:make], database)
      database = keep('model', search_rules_hash[:model], database)
      database = keep_range('year', search_rules_hash[:year_from], search_rules_hash[:year_to], database)
      database = keep_range('price', search_rules_hash[:price_from], search_rules_hash[:price_to], database)
      database = sort_by_option(database, search_rules_hash[:sort_option])
      database = sort_by_direction(database, search_rules_hash[:sort_direction])
      show_result(database)
      @running = exit?
    end
  end
end
