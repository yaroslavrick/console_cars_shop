# frozen_string_literal: true

module Lib
  class Console
    include Lib::Modules::InputOutput
    include Lib::Modules::Validation
    include Lib::Modules::Colorize
    SEARCH_RULES_OPTIONS = %i[make model year_from year_to price_from price_to].freeze

    attr_reader :total_requests, :result_data, :search_rules, :statistics_db, :cars_db, :printer

    def initialize
      @statistics_db = Lib::Models::Statistics.new
      @cars_db = Lib::Models::Cars.new
      @printer = Lib::PrintData.new
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
    end

    def print_result
      total_requests = statistics_db.find_total_requests(search_rules[:search_rules])
      show_prettified_result
      show_prettified_statistic(total_requests)
    end

    def show_prettified_result
      return puts colorize_text('title', localize('results.empty')).underline if result_data.empty?

      result_data.each do |car|
        localize_rows(car)
        rows = car.map do |key, value|
          [colorize_text('main', key.to_s), colorize_text('result', value.to_s)]
        end
        printer.create_table('results.title', 'results.params', 'results.data', rows)
      end
    end

    def show_prettified_statistic(total_requests)
      rows = [[colorize_text('main', localize('statistics.total_quantity')), colorize_text('result', result_data.count.to_s)],
              [colorize_text('main', localize('statistics.requests_quantity')), colorize_text('result', total_requests.to_s)]]
      printer.create_table('statistics.statistic', 'statistics.title', 'statistics.number', rows)
    end

    def localize_rows(car)
      car.transform_keys! do |key|
        localize("table.#{key}")
      end
    end

    def save_to_log
      database.save_log(search_rules, total_requests, result_data.count)
    end

    def ask_cars_fields
      input_data = initialize_search_rules
      input_data[:search_rules] = SEARCH_RULES_OPTIONS.each_with_object({}) do |item, hash|
        hash[item] = ask_field(item)
      end
      input_data[:sort_rules][:sort_option] = ask_field('sort option (date_added|price)')
      input_data[:sort_rules][:sort_direction] = ask_field('sort direction (desc|asc)')
      input_data
    end

    def initialize_search_rules
      {
        search_rules: {},
        sort_rules: {
          sort_option: nil,
          sort_direction: nil
        }
      }
    end

    def validate_user_input(params)
      fields_valid = field_less_then(params[:year_from],
                                     params[:year_to]) && field_less_then(params[:price_from],
                                                                          params[:price_to])

      raise localize('errors.wrong_field') unless fields_valid

      fields_valid
    end
  end
end
