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
