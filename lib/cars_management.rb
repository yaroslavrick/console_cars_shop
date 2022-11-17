module Lib
  class ::CarsManagement
    include Lib::Modules::InputOutput
    include Lib::Modules::SearchEngine
    include Lib::Modules::Validation

    def initialize
      @database = DataBase.new.load_database
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

    def ask_cars_fields
      @data = %i[make model year_from year_to price_from price_to sort_option
                 sort_direction].each_with_object({}) do |item, hash|
        hash[item] = ask_field(item)
      end
      @data
    end

    def run
      loop do
        search_rules = ask_cars_fields
        db = @database
        filtered_db = search_data(db, search_rules)
        sorted_db = sort(filtered_db, search_rules[:sort_option], search_rules[:sort_direction])
        show_result(sorted_db)
        break if exit?
      end
    end
  end
end
