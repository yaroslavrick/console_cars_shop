module Lib
  class Console
    include Lib::Modules::InputOutput
    include Lib::Modules::Validation

    attr_reader :total_requests, :result_data, :search_rules, :statistics_db, :cars_db

    def initialize
      @statistics_db = Lib::Models::Statistics.new
      @cars_db = Lib::Models::Cars.new
    end

    def call
      loop do
        search
        update_statistics
        print_result
        break if exit?
      end
    end

    private

    def search
      @search_rules = ask_cars_fields
      validate_user_input(search_rules[:search_rules])
      @result_data = Lib::SearchEngineQuery.new(data: cars_db.load.clone,
                                                params: search_rules).call
    end

    def update_statistics
      statistics_db.update(search_rules[:search_rules])
      statistics_db.create(search_rules[:search_rules])
    end

    def ask_cars_fields
      input_data = {}
      input_data[:search_rules] = {}
      input_data[:search_rules] = %i[make model year_from year_to price_from price_to].each_with_object({}) do |item, hash|
        hash[item] = ask_field(item)
      end
      input_data[:sort_rules] = {}
      input_data[:sort_rules][:sort_option] = ask_field('sort option (date_added|price)')
      input_data[:sort_rules][:sort_direction] = ask_field('sort direction (desc|asc)')
      input_data
    end

    def validate_user_input(params)
      fields_valid = field_less_then(params[:year_from],
                                     params[:year_to]) && field_less_then(params[:price_from],
                                                                          params[:price_to])

      raise "You entered wrong field: year_from/price_from can't be bigger than year_to/price_to" unless fields_valid

      fields_valid
    end

    def print_result
      total_requests = statistics_db.total_requests
      show_result(result_data)
      show_statistic(result_data.count, total_requests)
    end

    def show_statistic(total_quantity, requested_quantity)
      puts 'Statistic:'
      puts "Total Quantity: #{total_quantity}"
      puts "Requests quantity: #{requested_quantity}"
      puts "#{'-' * 15}\n\n"
    end
  end
end
