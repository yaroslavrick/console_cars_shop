module Lib
  class ::CarsManagement
    include Lib::Modules::InputOutput
    include Lib::Modules::Validation
    include Lib::Modules::Statistics

    def initialize
      @database = DataBase.new.load
      @requests_quantity = 1
    end

    def ask_cars_fields
      input_data = %i[make model year_from year_to price_from price_to].each_with_object({}) do |item, hash|
        hash[item] = ask_field(item)
      end
      input_data[:sort_option] = ask_field('sort option (date_added|price)')
      input_data[:sort_direction] = ask_field('sort direction (desc|asc)')
      # input_data
      create_query(input_data)
    end

    def validate_user_input?(params)
      fields_valid = field_less_then(params[:year_from],
                                     params[:year_to]) && field_less_then(params[:price_from],
                                                                          params[:price_to])
      raise "You entered wrong field: year_from/price_from can't be bigger than year_to/price_to" unless fields_valid

      fields_valid
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

    def run
      loop do
        search_rules = ask_cars_fields
        validate_user_input?(search_rules[:rules])
        result_data = Lib::SearchEngineQuery.new(data: @database.clone,
                                                 params: search_rules[:rules]).call
        show_result(result_data)

        searches_history = DataBase.new.load_log
        current_log = add_statistics(search_rules, result_data, @requests_quantity)
        @requests_quantity = compare_requests(current_log, searches_history)
        DataBase.new.save_log(search_rules, @requests_quantity, total_quantity(result_data))
        show_statistic(total_quantity(result_data), @requests_quantity)
        break if exit?

        @requests_quantity = 1
      end
    end
  end
end
