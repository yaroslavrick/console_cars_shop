class CarsManagement
  include Lib
  include InputOutput
  include SearchEngine

  def initialize
    @running = true
  end

  def print_message(message)
    puts message
  end

  def get_user_input
    gets.chomp
  end

  def ask_field(rule)
    case rule
    when :make
      question = 'make'
    when :model
      question = 'model'
    when :year_from
      question = 'year_from:'
    when :year_to
      question = 'year_to'
    when :price_from
      question = 'price_from'
    when :price_to
      question = 'price_to'
    when :sort_option
      question = 'sort option (date_added|price)'
    when :sort_direction
      question = 'sort direction(desc|asc)'
    end
    puts "Please choose #{question}:"
    get_user_input.downcase
  end

  def ask_user_input
    @data = %i[make model year_from year_to price_from price_to sort_option
               sort_direction].each_with_object({}) do |item, hash|
      hash[item] = ask_field(item)
    end
    @data
  end

  def run
    while @running == true
      database = DataBase.new.load_database
      search_rules = ask_user_input
      database = keep('make', search_rules[:make], database)
      database = keep('model', search_rules[:model], database)
      database = keep_range('year', search_rules[:year_from].to_i, search_rules[:year_to].to_i, database)
      database = keep_range('price', search_rules[:price_from].to_i, search_rules[:price_to].to_i, database)
      database = sort_by_option(database, search_rules[:sort_option])
      database = sort_by_direction(database, search_rules[:sort_direction])
      show_result(database)
      @running = exit?
    end
  end
end
