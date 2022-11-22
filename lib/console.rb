module Lib
  class Console
    include Lib::Modules::InputOutput
    include Lib::Modules::Validation

    def initialize
      @database = DataBase.new.load
    end

    def call
      loop do
        search
        statistics
        print_result
        save_to_log
        break if exit?
      end
    end

    private

    def search
      @search_rules = ask_cars_fields
      validate_user_input?(@search_rules)
      @result_data = Lib::SearchEngineQuery.new(data: @database.clone,
                                                params: @search_rules).call
    end

    def statistics
      searches_history = DataBase.new.load_log
      @requests = Statistics.new(rules: @search_rules, searches_history:).identical_requests
    end

    def print_result
      show_result(@result_data)
      show_statistic(@result_data.count, @requests)
    end

    def save_to_log
      DataBase.new.save_log(@search_rules, @requests, @result_data.count)
    end

    def ask_cars_fields
      input_data = %i[make model year_from year_to price_from price_to].each_with_object({}) do |item, hash|
        hash[item] = ask_field(item)
      end
      input_data[:sort_option] = ask_field('sort option (date_added|price)')
      input_data[:sort_direction] = ask_field('sort direction (desc|asc)')
      input_data
    end

    def validate_user_input?(params)
      fields_valid = field_less_then(params[:year_from],
                                     params[:year_to]) && field_less_then(params[:price_from],
                                                                          params[:price_to])
      raise "You entered wrong field: year_from/price_from can't be bigger than year_to/price_to" unless fields_valid

      fields_valid
    end
  end
end
