module Lib
  class ::CarsManagement
    include Lib::Modules::InputOutput
    include Lib::Modules::SearchEngineQuery
    include Lib::Modules::Validation

    def initialize
      @database = DataBase.new.load
    end

    def ask_cars_fields
      input_data = %i[make model year_from year_to price_from price_to].each_with_object({}) do |item, hash|
        hash[item] = ask_field(item)
      end
      input_data[:sort_option] = ask_field('sort option (date_added|price)')
      input_data[:sort_direction] = ask_field('sort direction (desc|asc)')
      input_data
    end

    def run
      loop do
        search_rules = ask_cars_fields
        db = @database.clone
        filtered_db = search_data(db, search_rules)
        sorted_db = sort(filtered_db, search_rules[:sort_option], search_rules[:sort_direction])
        show_result(sorted_db)
        break if exit?
      end
    end
  end
end
