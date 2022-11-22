module Lib
  class Console
    include Lib::Modules::InputOutput
    include Lib::Modules::Validation

    attr_reader :database

    def initialize
      @database = DataBase.new
    end

    def call
      loop do
        search
        print_result
        save_to_log
        break if exit?
      end
    end

    private

    def search
      @search_rules = ask_cars_fields
      validate_user_input?(@search_rules)
      @result_data = Lib::SearchEngineQuery.new(data: database.load.clone,
                                                params: @search_rules).call
    end

    def find_total_requests
      @total_requests = Statistics.new(rules: @search_rules, searches_history: database.load_log).identical_requests
    end

    def print_result
      find_total_requests
      show_result(@result_data)
      show_statistic(@result_data.count, @total_requests)
    end

    def save_to_log
      database.save_log(@search_rules, @total_requests, @result_data.count)
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

    def show_statistic(total_quantity, requested_quantity)
      puts 'Statistic:'
      puts "Total Quantity: #{total_quantity}"
      puts "Requests quantity: #{requested_quantity}"
      puts "#{'-' * 15}\n\n"
    end
  end
end
