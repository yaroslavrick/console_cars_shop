class CarsManagement
  include Lib
  include InputOutput
  include SearchEngine
  include Validation
  include InputOutput
  include Statistics

  def initialize
    @running = true
    @database = DataBase.new.load_database
    @requests_quantity = 1
  end

  def print_message(message)
    puts message
  end

  def user_input
    gets.chomp.strip.downcase
  end

  def ask_field(rule)
    question = case rule
               when :sort_option
                 'sort option (date_added|price)'
               when :sort_direction
                 'sort direction(desc|asc)'
               else
                 rule.to_s
               end

    puts "Please choose #{question}:"
    user_input.downcase
  end

  def create_query(data)
    {
      rules: {
        make: data[:make],
        model: data[:model],
        year_from: data[:year_from],
        year_to: data[:year_to],
        price_from: data[:price_from],
        price_to: data[:price_to],
        sort_option: data[:sort_option],
        sort_direction: data[:sort_direction]
      },
      stats: {}
    }
  end

  def ask_user_input
    data = %i[make model year_from year_to price_from price_to sort_option
              sort_direction].each_with_object({}) do |item, hash|
      hash[item] = ask_field(item)
    end
    create_query(data)
  end

  def run
    while @running == true
      @requests_quantity = 1
      search_rules = ask_user_input
      db = @database.clone
      filtered_db = search_data(db, search_rules[:rules])
      sorted_db = sort(filtered_db, search_rules[:rules][:sort_option], search_rules[:rules][:sort_direction])
      show_result(sorted_db)

      searches_history = DataBase.new.load_log
      current_log = add_statistics(search_rules, sorted_db, @requests_quantity)
      @requests_quantity = compare_requests(current_log, searches_history)
      show_statistic(sorted_db, @requests_quantity)
      total_quantity = total_quantity(sorted_db)
      DataBase.new.save_log(search_rules, @requests_quantity, total_quantity)
      @running = exit?
    end
  end
end
