class CarsManagement
  include Lib
  include InputOutput
  include SearchEngine
  include Validation

  def initialize
    @running = true
    @database = DataBase.new.load_database
  end

  def print_message(message)
    puts message
  end

  def user_input
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
    user_input.downcase
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
      search_rules = ask_user_input
      db = @database
      filtered_db = search_data(db, search_rules)
      sorted_db = sort(filtered_db, search_rules[:sort_option], search_rules[:sort_direction])
      show_result(sorted_db)
      @running = exit?
    end
  end
end
