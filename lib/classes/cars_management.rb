class CarsManagement
  include InputOutput
  include DataBase
  include SearchEngine
  include Statistics

  def initialize
    @running = true
    @requests_quantity = 1
  end

  def run
    while @running == true
      @requests_quantity = 1
      search_rules_hash = ask_user_input
      database = load_database
      database = keep('make', search_rules_hash[:rules][:make], database)
      database = keep('model', search_rules_hash[:rules][:model], database)
      database = keep_range('year', search_rules_hash[:rules][:year_from], search_rules_hash[:rules][:year_to],
                            database)
      database = keep_range('price', search_rules_hash[:rules][:price_from], search_rules_hash[:rules][:price_to],
                            database)
      database = sort_by_option(database, search_rules_hash[:rules][:sort_option])
      database = sort_by_direction(database, search_rules_hash[:rules][:sort_direction])
      searches_history_arr = load_log
      current_log_hash = add_statistics(search_rules_hash, database, @requests_quantity)
      @requests_quantity = compare_requests(current_log_hash, searches_history_arr, @requests_quantity)
      show_statistic(database, @requests_quantity)
      show_result(database)
      total_quantity = total_quantity(database)
      save_log(search_rules_hash, @requests_quantity, total_quantity)
      @running = exit?
    end
  end
end
